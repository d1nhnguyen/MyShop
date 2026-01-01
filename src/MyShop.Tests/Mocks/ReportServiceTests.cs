using MyShop.App.Services;
using MyShop.Core.Models;
using MyShop.Tests.Mocks;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Xunit;

namespace MyShop.Tests.UnitTests.Services
{
    public class ReportServiceTests
    {
        private readonly MockReportRepository _mockRepository;
        private readonly ReportService _service;

        public ReportServiceTests()
        {
            _mockRepository = new MockReportRepository();
            _service = new ReportService(_mockRepository);
        }

        [Fact]
        public async Task GetDashboardReportAsync_ShouldReturnCorrectTotals()
        {
            // Arrange
            _mockRepository.MockPeriodReport = new PeriodReport
            {
                TotalRevenue = 9999,
                TotalOrders = 50
            };

            // Act
            var result = await _service.GetDashboardReportAsync(PeriodType.MONTHLY);

            // Assert
            Assert.NotNull(result);
            Assert.Equal(9999, result.TotalRevenue);
            Assert.Equal(50, result.TotalOrders);
        }

        [Fact]
        public async Task GetTopSellingProductsAsync_ShouldReturnProducts()
        {
            // Act
            var result = await _service.GetTopSellingProductsAsync(DateTime.Now, DateTime.Now);

            // Assert
            Assert.NotEmpty(result);
            Assert.Equal("Test Product", result.First().ProductName);
        }

        [Fact]
        public async Task GetBestCustomersAsync_ShouldReturnCustomers()
        {
            // Act
            var result = await _service.GetBestCustomersAsync(DateTime.Now, DateTime.Now);

            // Assert
            Assert.Single(result);
            Assert.Equal("Test Customer", result.First().CustomerName);
        }

        [Fact]
        public async Task GetStaffPerformanceAsync_ShouldReturnStaffData()
        {
            // Act
            var result = await _service.GetStaffPerformanceAsync(DateTime.Now, DateTime.Now);

            // Assert
            Assert.Single(result);
            Assert.Equal("Staff1", result.First().Username);
        }
    }
}