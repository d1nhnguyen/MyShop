using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Media.Imaging;
using MyShop.Core.Models;
using System;
using System.Threading.Tasks;
using Windows.Storage.Pickers;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using MyShop.Core.Interfaces.Services;

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
            catch { }
        }

        private async void OnPrimaryButtonClick(ContentDialog sender, ContentDialogButtonClickEventArgs args)
        {
            var deferral = args.GetDeferral();

            try
            {
                if (string.IsNullOrWhiteSpace(NameBox.Text) || string.IsNullOrWhiteSpace(SkuBox.Text))
                {
                    NameBox.BorderBrush = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.Red);
                    args.Cancel = true;
                    return;
                }

                string imageUrl = null;
                if (!string.IsNullOrEmpty(_selectedImagePath))
                {
                    imageUrl = await UploadImageAsync(_selectedImagePath);
                }

                NewProduct = new Product
                {
                    Name = NameBox.Text,
                    Description = DescBox.Text,
                    Sku = SkuBox.Text,
                    Price = (decimal)PriceBox.Value,
                    Stock = (int)StockBox.Value,
                    CategoryId = CategoryCombo.SelectedIndex + 1,
                    ImageUrl = imageUrl, // Set the uploaded URL
                    CreatedAt = DateTime.UtcNow,
                    UpdatedAt = DateTime.UtcNow
                };
            }
            finally
            {
                deferral.Complete();
            }
        }

        private async Task<string> UploadImageAsync(string filePath)
        {
            try
            {
                var file = await Windows.Storage.StorageFile.GetFileFromPathAsync(filePath);
                using var stream = await file.OpenReadAsync();

                var reader = new Windows.Storage.Streams.DataReader(stream.GetInputStreamAt(0));
                var bytes = new byte[stream.Size];
                await reader.LoadAsync((uint)stream.Size);
                reader.ReadBytes(bytes);
                string base64 = Convert.ToBase64String(bytes);

                var payload = new { image = base64, fileName = file.Name };

                // Resolve API URL
                string serverUrl = "http://localhost:4000";
                var configService = App.Current.GetService<IConfigService>();
                if (configService != null)
                {
                    var url = configService.GetServerUrl();
                    if (url.Contains("/graphql")) serverUrl = url.Replace("/graphql", "");
                    else serverUrl = url;
                    serverUrl = serverUrl.TrimEnd('/');
                }

                using var client = new HttpClient();
                var json = JsonSerializer.Serialize(payload);
                var content = new StringContent(json, Encoding.UTF8, "application/json");

                var response = await client.PostAsync($"{serverUrl}/api/upload", content);
                response.EnsureSuccessStatusCode();

                var responseString = await response.Content.ReadAsStringAsync();
                var result = JsonSerializer.Deserialize<UploadResponse>(responseString);

                return result?.url;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Upload failed: {ex.Message}");
                return null;
            }
        }

        private void OnCloseButtonClick(ContentDialog sender, ContentDialogButtonClickEventArgs args)
        {
            NewProduct = null;
        }

        private class UploadResponse
        {
            public string url { get; set; }
        }
    }
}