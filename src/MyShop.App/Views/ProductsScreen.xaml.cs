using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.Extensions.DependencyInjection;
using MyShop.App.ViewModels;
using MyShop.App.Views.Dialogs;
using System;

namespace MyShop.App.Views
{
    public sealed partial class ProductsScreen : Page
    {
        public ProductViewModel ViewModel { get; }

        public ProductsScreen()
        {
            this.InitializeComponent();
            ViewModel = App.Current.Services.GetService<ProductViewModel>();
        }

        private async void OnAddProductClick(object sender, RoutedEventArgs e)
        {
            var dialog = new AddProductDialog();
            dialog.XamlRoot = this.XamlRoot;

            await dialog.ShowAsync();

            if (dialog.NewProduct != null)
            {
                await ViewModel.AddProductAsync(dialog.NewProduct);
            }
        }

        private async void OnSearchQuerySubmitted(AutoSuggestBox sender, AutoSuggestBoxQuerySubmittedEventArgs args)
        {
            await ViewModel.SearchProductsAsync(args.QueryText);
        }

        private async void OnSearchTextChanged(AutoSuggestBox sender, AutoSuggestBoxTextChangedEventArgs args)
        {
            if (args.Reason == AutoSuggestionBoxTextChangeReason.UserInput && string.IsNullOrWhiteSpace(sender.Text))
            {
                await ViewModel.SearchProductsAsync(string.Empty);
            }
        }
    }
}