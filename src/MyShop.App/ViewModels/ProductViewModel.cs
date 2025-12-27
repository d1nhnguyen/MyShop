using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using MyShop.App.Services;
using MyShop.App.ViewModels.Base;
using MyShop.Core.Interfaces.Repositories;
using MyShop.Core.Models;

namespace MyShop.App.ViewModels
{
    public class CategoryStat
    {
        public string Name { get; set; }
        public int Count { get; set; }
        public int Id { get; set; }
        public string DisplayText => $"{Name} ({Count})";
    }

    public class ProductViewModel : ViewModelBase
    {
        private readonly ProductService _productService;

        private List<Product> _allProducts;
        private ObservableCollection<Product> _products;
        private CategoryStat _selectedCategory;
        private ObservableCollection<CategoryStat> _categories;

        private string _currentSearchTerm = string.Empty;
        private decimal? _minPrice = null;
        private decimal? _maxPrice = null;
        private string _primarySort = null;

        public ProductViewModel(IProductRepository productRepository)
        {
            // Initialize the service
            _productService = new ProductService(productRepository);

            _products = new ObservableCollection<Product>();
            _allProducts = new List<Product>();
            _categories = new ObservableCollection<CategoryStat>();

            _ = LoadProductsAsync();
        }

        public ObservableCollection<Product> Products
        {
            get => _products;
            set => SetProperty(ref _products, value);
        }

        public CategoryStat SelectedCategory
        {
            get => _selectedCategory;
            set
            {
                if (SetProperty(ref _selectedCategory, value))
                {
                    FilterProducts();
                }
            }
        }

        public async Task LoadProductsAsync()
        {
            if (IsBusy) return;
            try
            {
                IsBusy = true;
                var dbData = await _productService.LoadProductsAsync();

                _allProducts.Clear();
                _allProducts.AddRange(dbData);

                FilterProducts();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        // --- RESTORED METHOD ---
        public void SelectCategoryById(int categoryId)
        {
            // Create a temporary stat to trigger the filter logic.
            // The ID is the only thing strictly needed for the filter logic to work.
            SelectedCategory = new CategoryStat { Id = categoryId, Name = "Selection" };
        }
        // -----------------------

        public Task SearchProductsAsync(string keyword)
        {
            _currentSearchTerm = keyword;
            FilterProducts();
            return Task.CompletedTask;
        }

        private void FilterProducts()
        {
            // 1. Search
            var filtered = _productService.SearchProducts(_allProducts, _currentSearchTerm);

            // 2. Filter by Category
            if (SelectedCategory != null && SelectedCategory.Id != 0)
            {
                filtered = _productService.FilterByCategory(filtered, SelectedCategory.Id);
            }

            // 3. Filter by Price
            filtered = _productService.FilterByPriceRange(filtered, _minPrice, _maxPrice);

            // 4. Sort
            if (!string.IsNullOrEmpty(_primarySort))
            {
                filtered = _productService.SortProducts(filtered, _primarySort);
            }

            Products = new ObservableCollection<Product>(filtered);
        }

        public async Task AddProductAsync(Product newProduct)
        {
            await _productService.AddProductAsync(newProduct);
            _allProducts.Add(newProduct);
            FilterProducts();
        }

        public async Task UpdateProductAsync(Product updatedProduct)
        {
            await _productService.UpdateProductAsync(updatedProduct);
            var index = _allProducts.FindIndex(p => p.Id == updatedProduct.Id);
            if (index >= 0) _allProducts[index] = updatedProduct;
            FilterProducts();
        }

        public async Task DeleteProductAsync(int productId)
        {
            await _productService.DeleteProductAsync(productId);
            var p = _allProducts.FirstOrDefault(x => x.Id == productId);
            if (p != null) _allProducts.Remove(p);
            FilterProducts();
        }

        public void SetPriceRange(decimal? minPrice, decimal? maxPrice)
        {
            _minPrice = minPrice;
            _maxPrice = maxPrice;
            FilterProducts();
        }

        public void SetSorting(string primarySort, string secondarySort)
        {
            _primarySort = primarySort;
            FilterProducts();
        }
    }
}