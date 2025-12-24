using Microsoft.UI.Xaml.Controls;
using MyShop.App.ViewModels;

namespace MyShop.App.Views
{
    public sealed partial class CustomersPage : Page
    {
        public CustomersViewModel ViewModel { get; }

        public CustomersPage()
        {
            this.InitializeComponent();
            ViewModel = App.Current.GetService<CustomersViewModel>();
        }
    }
}
