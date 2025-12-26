using Microsoft.UI;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Media;
using MyShop.Core.Models;
using System;
using System.Linq;

namespace MyShop.App.Views.Dialogs
{
    public sealed partial class OrderDetailDialog : ContentDialog
    {
        private readonly Order _order;

        public OrderDetailDialog(Order order)
        {
            this.InitializeComponent();
            _order = order;
            LoadOrderDetails();
        }

        private void LoadOrderDetails()
        {
            // Order Header
            OrderNumberText.Text = _order.OrderNumber;
            OrderDateText.Text = $"Order Date: {_order.CreatedAt:MMM dd, yyyy HH:mm}";

            // Status
            StatusText.Text = _order.Status.ToString();
            StatusBorder.Background = GetStatusBrush(_order.Status);

            // Customer Information
            if (_order.Customer != null)
            {
                CustomerNameText.Text = _order.Customer.Name;
                CustomerPhoneText.Text = _order.Customer.Phone ?? "N/A";
                CustomerEmailText.Text = _order.Customer.Email ?? "N/A";
            }
            else
            {
                CustomerNameText.Text = "Walk-in Customer";
                CustomerPhoneText.Text = "N/A";
                CustomerEmailText.Text = "N/A";
            }

            // Order Items
            if (_order.OrderItems != null && _order.OrderItems.Any())
            {
                OrderItemsList.ItemsSource = _order.OrderItems;
            }

            // Order Summary
            SubtotalText.Text = $"${_order.Subtotal:F2}";
            DiscountText.Text = _order.DiscountAmount > 0
                ? $"-${_order.DiscountAmount:F2}"
                : "$0.00";
            TaxText.Text = $"${_order.TaxAmount:F2}";
            TotalText.Text = $"${_order.Total:F2}";

            // Notes
            NotesText.Text = _order.Notes ?? "No notes";

            // Metadata
            CreatedByText.Text = _order.CreatedBy?.Username ?? "System";
            CreatedAtText.Text = _order.CreatedAt.ToString("MMM dd, yyyy HH:mm");

            if (_order.CompletedAt.HasValue)
            {
                CompletedAtTextBlock.Visibility = Visibility.Visible;
                CompletedAtText.Text = _order.CompletedAt.Value.ToString("MMM dd, yyyy HH:mm");
            }
            else
            {
                CompletedAtTextBlock.Visibility = Visibility.Collapsed;
            }
        }

        private SolidColorBrush GetStatusBrush(OrderStatus status)
        {
            return status switch
            {
                OrderStatus.PENDING => new SolidColorBrush(ColorHelper.FromArgb(255, 255, 165, 0)), // Orange
                OrderStatus.PROCESSING => new SolidColorBrush(ColorHelper.FromArgb(255, 65, 105, 225)), // Royal Blue
                OrderStatus.COMPLETED => new SolidColorBrush(ColorHelper.FromArgb(255, 50, 205, 50)), // Lime Green
                OrderStatus.CANCELLED => new SolidColorBrush(ColorHelper.FromArgb(255, 220, 20, 60)), // Crimson
                _ => new SolidColorBrush(ColorHelper.FromArgb(255, 128, 128, 128)) // Gray
            };
        }
    }
}
