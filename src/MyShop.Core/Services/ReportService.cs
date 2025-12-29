using MyShop.Core.Interfaces.Repositories;
using MyShop.Core.Models;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MyShop.App.Services // Namespace matches ProductService
{
    public class ReportService
    {
        private readonly IReportRepository _reportRepository;

        public ReportService(IReportRepository reportRepository)
        {
            _reportRepository = reportRepository;
        }

        public async Task<PeriodReport?> GetDashboardReportAsync(PeriodType period)
        {
            // Example logic: Default to last 30 days if period is custom but dates missing (simplified)
            return await _reportRepository.GetReportByPeriodAsync(period);
        }

        public async Task<List<ProductSalesData>> GetTopSellingProductsAsync(DateTime start, DateTime end)
        {
            return await _reportRepository.GetTopProductsByQuantityAsync(start, end);
        }

        public async Task<List<CustomerSalesData>> GetBestCustomersAsync(DateTime start, DateTime end, int topN = 10)
        {
            if (topN <= 0) topN = 10;
            return await _reportRepository.GetTopCustomersAsync(start, end, topN);
        }

        public async Task<List<RevenueProfit>> GetRevenueChartDataAsync(DateTime start, DateTime end)
        {
            return await _reportRepository.GetRevenueAndProfitTimelineAsync(start, end, TimelineGrouping.DAY);
        }

        public async Task<List<StaffPerformanceData>> GetStaffPerformanceAsync(DateTime start, DateTime end)
        {
            return await _reportRepository.GetAllStaffPerformanceAsync(start, end);
        }
    }
}