using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using MyShop.Core.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Threading.Tasks;

namespace MyShop.App.ViewModels
{
    public partial class CustomersViewModel : ObservableObject
    {
        [ObservableProperty]
        private ObservableCollection<Customer> _customers = new();
        
        [ObservableProperty]
        private Customer? _selectedCustomer;
        
        [ObservableProperty]
        private string _searchText = string.Empty;
        
        [ObservableProperty]
        private int _currentPage = 1;
        
        [ObservableProperty]
        private int _totalPages = 1;
        
        [ObservableProperty]
        private int _totalCustomers;
        
        [ObservableProperty]
        private bool _isLoading;
        
        private int _pageSize = 10;

        public CustomersViewModel()
        {
            LoadMockData();
        }

        [RelayCommand]
        private async Task LoadCustomersAsync()
        {
            IsLoading = true;
            // Simulate delay
            await Task.Delay(500);
            
            // TODO: Replace with actual service call
            // var result = await _customerService.GetCustomersAsync(SearchText, CurrentPage, _pageSize);
            
            IsLoading = false;
        }

        [RelayCommand]
        private void Export()
        {
            // TODO: Implement export logic
        }

        [RelayCommand]
        private void AddCustomer()
        {
            // TODO: Implement add customer logic
        }

        [RelayCommand]
        private void NextPage()
        {
            if (CurrentPage < TotalPages)
            {
                CurrentPage++;
            }
        }

        [RelayCommand]
        private void PrevPage()
        {
            if (CurrentPage > 1)
            {
                CurrentPage--;
            }
        }

        partial void OnSearchTextChanged(string value)
        {
            _ = LoadCustomersAsync();
        }

        partial void OnCurrentPageChanged(int value)
        {
            _ = LoadCustomersAsync();
        }

        private void LoadMockData()
        {
            var mockData = new List<Customer>
            {
                new Customer { Id = 1, Name = "Kavin", Email = "kavin@example.com", Phone = "123-456-7890", TotalSpent = 100000, CreatedAt = DateTime.Now.AddDays(-1), IsMember = true },
                new Customer { Id = 2, Name = "Komael", Email = "komael@example.com", Phone = "987-654-3210", TotalSpent = 150000, CreatedAt = DateTime.Now.AddDays(-2), IsMember = false },
                new Customer { Id = 3, Name = "Nikhil", Email = "nikhil@example.com", Phone = "555-123-4567", TotalSpent = 200000, CreatedAt = DateTime.Now.AddDays(-3), IsMember = true },
                new Customer { Id = 4, Name = "Shivam", Email = "shivam@example.com", Phone = "444-555-6666", TotalSpent = 50000, CreatedAt = DateTime.Now.AddDays(-4), IsMember = false },
                new Customer { Id = 5, Name = "Shadab", Email = "shadab@example.com", Phone = "111-222-3333", TotalSpent = 75000, CreatedAt = DateTime.Now.AddDays(-5), IsMember = true },
                new Customer { Id = 6, Name = "Yogesh", Email = "yogesh@example.com", Phone = "999-888-7777", TotalSpent = 120000, CreatedAt = DateTime.Now.AddDays(-6), IsMember = false },
                new Customer { Id = 7, Name = "Sunita", Email = "sunita@example.com", Phone = "777-666-5555", TotalSpent = 300000, CreatedAt = DateTime.Now.AddDays(-7), IsMember = true },
                new Customer { Id = 8, Name = "Priyanka", Email = "priyanka@example.com", Phone = "333-444-5555", TotalSpent = 90000, CreatedAt = DateTime.Now.AddDays(-8), IsMember = false },
            };

            Customers = new ObservableCollection<Customer>(mockData);
            TotalCustomers = mockData.Count;
            TotalPages = 1;
        }
    }
}
