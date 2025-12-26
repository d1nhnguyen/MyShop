using Microsoft.UI.Xaml.Data;
using Microsoft.UI.Xaml.Media.Imaging;
using System;

namespace MyShop.App.Converters
{
    public class StringToImageSourceConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, string language)
        {
            if (value is string url && !string.IsNullOrWhiteSpace(url))
            {
                try
                {
                    return new BitmapImage(new Uri(url));
                }
                catch
                {
                    // If URL is invalid, return null to avoid crash
                    return null;
                }
            }
            return null;
        }

        public object ConvertBack(object value, Type targetType, object parameter, string language)
        {
            throw new NotImplementedException();
        }
    }
}