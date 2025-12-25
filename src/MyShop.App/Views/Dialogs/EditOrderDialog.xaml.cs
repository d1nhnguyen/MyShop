using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using MyShop.App.ViewModels;
using MyShop.Core.Models;
using System;
using System.Linq;

namespace MyShop.App.Views.Dialogs
{
    public sealed partial class EditOrderDialog : ContentDialog
    {
        private readonly OrderViewModel _viewModel;
        private readonly Order _order;

        public EditOrderDialog(OrderViewModel viewModel, Order order)
        {
            this.InitializeComponent();
            _viewModel = viewModel;
            _order = order;

            LoadOrderData();
        }

        private void LoadOrderData()
        {
            OrderNumberTextBox.Text = _order.OrderNumber;
            NotesTextBox.Text = _order.Notes ?? string.Empty;

            // Set status
            switch (_order.Status)
            {
                case OrderStatus.PENDING:
                    StatusComboBox.SelectedIndex = 0;
                    break;
                case OrderStatus.PROCESSING:
                    StatusComboBox.SelectedIndex = 1;
                    break;
                case OrderStatus.COMPLETED:
                    StatusComboBox.SelectedIndex = 2;
                    break;
                default:
                    StatusComboBox.SelectedIndex = 0;
                    break;
            }

            // Display order summary
            CustomerText.Text = _order.Customer?.Name ?? "Walk-in Customer";
            CreatedDateText.Text = _order.CreatedAt.ToString("MMM dd, yyyy HH:mm");
            TotalItemsText.Text = _order.OrderItems?.Count.ToString() ?? "0";
            TotalAmountText.Text = $"${_order.Total:F2}";

            // Disable editing if order is cancelled or completed
            if (_order.Status == OrderStatus.CANCELLED || _order.Status == OrderStatus.COMPLETED)
            {
                StatusComboBox.IsEnabled = false;
                NotesTextBox.IsReadOnly = true;
                IsPrimaryButtonEnabled = false;
            }
        }

        private async void OnSaveClick(ContentDialog sender, ContentDialogButtonClickEventArgs args)
        {
            // Get selected status
            var selectedItem = StatusComboBox.SelectedItem as ComboBoxItem;
            var statusTag = selectedItem?.Tag as string;

            if (string.IsNullOrEmpty(statusTag))
            {
                args.Cancel = true;
                var errorDialog = new ContentDialog
                {
                    Title = "Validation Error",
                    Content = "Please select a valid status.",
                    CloseButtonText = "OK",
                    XamlRoot = this.XamlRoot
                };
                await errorDialog.ShowAsync();
                return;
            }

            // Parse status
            if (!Enum.TryParse<OrderStatus>(statusTag, out var newStatus))
            {
                args.Cancel = true;
                return;
            }

            // Update order
            _order.Status = newStatus;
            _order.Notes = NotesTextBox.Text;

            var success = await _viewModel.UpdateOrderAsync(_order);
            if (!success)
            {
                args.Cancel = true;
                var errorDialog = new ContentDialog
                {
                    Title = "Error",
                    Content = _viewModel.ErrorMessage ?? "Failed to update order",
                    CloseButtonText = "OK",
                    XamlRoot = this.XamlRoot
                };
                await errorDialog.ShowAsync();
            }
        }
    }
}
