using Microsoft.Extensions.DependencyInjection;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using MyShop.App.ViewModels;
using System;

namespace MyShop.App.Views
{
    public sealed partial class ShellPage : Page
    {
        public ShellViewModel ViewModel { get; }

        public ShellPage()
        {
            this.InitializeComponent();
            ViewModel = App.Current.Services.GetRequiredService<ShellViewModel>();
            ViewModel.LogoutRequested += OnLogoutRequested;

            // Handle Navigation
            NavView.SelectionChanged += NavView_SelectionChanged;
            NavView.Loaded += NavView_Loaded;
        }

        private void NavView_Loaded(object sender, RoutedEventArgs e)
        {
            // Set initial page
            NavView.SelectedItem = NavView.MenuItems[0]; // Dashboard
        }

        private void NavView_SelectionChanged(NavigationView sender, NavigationViewSelectionChangedEventArgs args)
        {
            if (args.IsSettingsSelected)
            {
                // ContentFrame.Navigate(typeof(SettingsPage));
            }
            else
            {
                var selectedItem = args.SelectedItem as NavigationViewItem;
                if (selectedItem != null)
                {
                    string tag = selectedItem.Tag.ToString();
                    Type pageType = null;

                    switch (tag)
                    {
                        case "Dashboard":
                            pageType = typeof(Dashboard);
                            break;
                        case "Products":
                            pageType = typeof(ProductsScreen);
                            break;
                        case "Orders":
                            pageType = typeof(OrdersPage);
                            break;
                        case "Reports":
                            pageType = typeof(ReportsPage);
                            break;
                        case "Categories":
                            // pageType = typeof(ProductsScreen);
                            break;
                    }

                    if (pageType != null)
                    {
                        ContentFrame.Navigate(pageType);
                    }
                }
            }
        }

        // ... existing methods (OnManageProductsClick, OnLogoutRequested) ...

        private void OnManageProductsClick(object sender, RoutedEventArgs e)
        {
            this.Frame.Navigate(typeof(ProductsScreen));
        }

        private void OnLogoutRequested()
        {
            if (Frame.CanGoBack)
            {
                Frame.GoBack();
            }
            else
            {
                Frame.Navigate(typeof(LoginScreen));
            }
        }
    }
}