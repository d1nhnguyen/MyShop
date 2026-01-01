using MyShop.Core.Interfaces.Strategies;
using MyShop.Core.Models;
using MyShop.Core.Strategies; // Assumes strategies are here
using System.Collections.Generic;
using System.Linq;
using Xunit;

namespace MyShop.Tests.UnitTests.Strategies
{
    public class SortStrategyTests
    {
        private readonly List<Product> _products;

        public SortStrategyTests()
        {
            _products = new List<Product>
            {
                new Product { Id = 1, Name = "Laptop", Price = 1000, Stock = 5 },
                new Product { Id = 2, Name = "Mouse", Price = 20, Stock = 50 },
                new Product { Id = 3, Name = "Keyboard", Price = 50, Stock = 30 },
                new Product { Id = 4, Name = "Monitor", Price = 300, Stock = 10 }
            };
        }

        [Fact]
        public void PriceAscSortStrategy_ShouldSortLowToHigh()
        {
            ISortStrategy strategy = new PriceAscSortStrategy();

            var result = strategy.Sort(_products);

            Assert.Equal(4, result.Count);
            Assert.Equal("Mouse", result.First().Name); // Lowest Price (20)
            Assert.Equal("Laptop", result.Last().Name); // Highest Price (1000)
        }

        [Fact]
        public void PriceDescSortStrategy_ShouldSortHighToLow()
        {
            ISortStrategy strategy = new PriceDescSortStrategy();

            var result = strategy.Sort(_products);

            Assert.Equal("Laptop", result.First().Name); // Highest Price
            Assert.Equal("Mouse", result.Last().Name); // Lowest Price
        }

        [Fact]
        public void NameAscSortStrategy_ShouldSortAlphabetically()
        {
            ISortStrategy strategy = new NameAscSortStrategy();

            var result = strategy.Sort(_products);

            Assert.Equal("Keyboard", result.First().Name); // K comes first
            Assert.Equal("Mouse", result.Last().Name);     // M comes last (among K, L, M, M - Monitor vs Mouse)

            // Verify 'Monitor' vs 'Mouse' order (Mo... n vs u)
            var mouseIndex = result.FindIndex(p => p.Name == "Mouse");
            var monitorIndex = result.FindIndex(p => p.Name == "Monitor");
            Assert.True(monitorIndex < mouseIndex);
        }

        [Fact]
        public void StockDescSortStrategy_ShouldSortByHighestStock()
        {
            ISortStrategy strategy = new StockDescSortStrategy();

            var result = strategy.Sort(_products);

            Assert.Equal(50, result.First().Stock); // Mouse
            Assert.Equal(5, result.Last().Stock);   // Laptop
        }
    }
}