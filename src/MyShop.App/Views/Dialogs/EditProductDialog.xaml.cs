using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Media.Imaging;
using MyShop.Core.Models;
using System;
using System.Threading.Tasks;
using Windows.Storage.Pickers;

namespace MyShop.App.Views.Dialogs
{
    public sealed partial class EditProductDialog : ContentDialog
    {
        public Product UpdatedProduct { get; private set; }
        private Product _originalProduct;
        private string _selectedImagePath;

        public EditProductDialog(Product product)
        {
            this.InitializeComponent();
            _originalProduct = product;
            LoadProductData();
        }

        private void LoadProductData()
        {
            NameBox.Text = _originalProduct.Name;
            DescBox.Text = _originalProduct.Description;
            SkuBox.Text = _originalProduct.Sku;
            PriceBox.Value = (double)_originalProduct.Price;
            StockBox.Value = _originalProduct.Stock;

            // Adjust index to match 0-based ComboBox (Category IDs start at 1)
            if (_originalProduct.CategoryId > 0)
            {
                CategoryCombo.SelectedIndex = _originalProduct.CategoryId - 1;
            }

            if (!string.IsNullOrEmpty(_originalProduct.ImageUrl))
            {
                
            }
        }

        private async void OnUploadClick(object sender, RoutedEventArgs e)
        {
            try
            {
                var picker = new FileOpenPicker();
                var window = App.MainWindowInstance;

                if (window != null)
                {
                    var hwnd = WinRT.Interop.WindowNative.GetWindowHandle(window);
                    WinRT.Interop.InitializeWithWindow.Initialize(picker, hwnd);

                    picker.ViewMode = PickerViewMode.Thumbnail;
                    picker.SuggestedStartLocation = PickerLocationId.PicturesLibrary;
                    picker.FileTypeFilter.Add(".jpg");
                    picker.FileTypeFilter.Add(".jpeg");
                    picker.FileTypeFilter.Add(".png");

                    var file = await picker.PickSingleFileAsync();
                    if (file != null)
                    {
                        var bitmap = new BitmapImage();
                        await bitmap.SetSourceAsync(await file.OpenAsync(Windows.Storage.FileAccessMode.Read));

                        PreviewImage.Source = bitmap;
                        DefaultIcon.Visibility = Visibility.Collapsed;
                        _selectedImagePath = file.Path;
                    }
                }
            }
            catch { }
        }

        private void OnPrimaryButtonClick(ContentDialog sender, ContentDialogButtonClickEventArgs args)
        {
            if (string.IsNullOrWhiteSpace(NameBox.Text) || string.IsNullOrWhiteSpace(SkuBox.Text))
            {
                NameBox.BorderBrush = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.Red);
                args.Cancel = true;
                return;
            }

            UpdatedProduct = new Product
            {
                Id = _originalProduct.Id, // Important: Keep the same ID
                Name = NameBox.Text,
                Description = DescBox.Text,
                Sku = SkuBox.Text,
                Price = (decimal)PriceBox.Value,
                Stock = (int)StockBox.Value,
                CategoryId = CategoryCombo.SelectedIndex + 1,
                ImageUrl = _selectedImagePath ?? _originalProduct.ImageUrl,
                CreatedAt = _originalProduct.CreatedAt,
                UpdatedAt = DateTime.UtcNow,
                IsActive = _originalProduct.IsActive
            };
        }

        private void OnCloseButtonClick(ContentDialog sender, ContentDialogButtonClickEventArgs args)
        {
            UpdatedProduct = null;
        }
    }
}