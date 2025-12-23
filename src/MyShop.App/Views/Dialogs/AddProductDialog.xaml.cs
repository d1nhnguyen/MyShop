using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Media.Imaging;
using MyShop.Core.Models;
using System;
using System.Threading.Tasks;
using Windows.Storage.Pickers;

namespace MyShop.App.Views.Dialogs
{
    public sealed partial class AddProductDialog : ContentDialog
    {
        public Product NewProduct { get; private set; }
        private string _selectedImagePath;

        public AddProductDialog()
        {
            this.InitializeComponent();
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
            catch
            {
            }
        }

        private void OnPrimaryButtonClick(ContentDialog sender, ContentDialogButtonClickEventArgs args)
        {
            if (string.IsNullOrWhiteSpace(NameBox.Text) || string.IsNullOrWhiteSpace(SkuBox.Text))
            {
                NameBox.BorderBrush = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.Red);
                args.Cancel = true;
                return;
            }

            NewProduct = new Product
            {
                Name = NameBox.Text,
                Description = DescBox.Text,
                Sku = SkuBox.Text,
                Price = (decimal)PriceBox.Value,
                Stock = (int)StockBox.Value,
                CategoryId = CategoryCombo.SelectedIndex + 1,
                IsActive = true,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };
        }

        private void OnCloseButtonClick(ContentDialog sender, ContentDialogButtonClickEventArgs args)
        {
            NewProduct = null;
        }
    }
}