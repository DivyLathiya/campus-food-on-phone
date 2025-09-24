import 'package:campus_food_app/data/datasources/mock_data_source.dart';
import 'package:campus_food_app/data/models/sales_report_model.dart';
import 'package:campus_food_app/domain/entities/sales_report_entity.dart';
import 'package:campus_food_app/domain/repositories/sales_report_repository.dart';

class MockSalesReportRepository implements SalesReportRepository {
  @override
  Future<SalesReportEntity> getDailyReport(String vendorId, DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final report = MockDataSource.getDailySalesReport(vendorId, date);
    return _convertToEntity(report);
  }

  @override
  Future<SalesReportEntity> getWeeklyReport(String vendorId, DateTime weekStart) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final report = MockDataSource.getWeeklySalesReport(vendorId, weekStart);
    return _convertToEntity(report);
  }

  @override
  Future<SalesReportEntity> getMonthlyReport(String vendorId, DateTime month) async {
    await Future.delayed(const Duration(milliseconds: 700));
    
    final report = MockDataSource.getMonthlySalesReport(vendorId, month);
    return _convertToEntity(report);
  }

  @override
  Future<List<SalesReportEntity>> getReportsByDateRange(
    String vendorId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final reports = MockDataSource.getSalesReportsByDateRange(vendorId, startDate, endDate);
    return reports.map((report) => _convertToEntity(report)).toList();
  }

  @override
  Future<List<SalesItemEntity>> getTopSellingItems(
    String vendorId,
    DateTime startDate,
    DateTime endDate,
    int limit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final items = MockDataSource.getTopSellingItems(vendorId, startDate, endDate, limit);
    return items.map((item) => SalesItemEntity(
      menuItemId: item.menuItemId,
      name: item.name,
      quantitySold: item.quantitySold,
      totalRevenue: item.totalRevenue,
      orderCount: item.orderCount,
    )).toList();
  }

  @override
  Future<List<DiscountUsageEntity>> getDiscountUsage(
    String vendorId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final usage = MockDataSource.getDiscountUsage(vendorId, startDate, endDate);
    return usage.map((item) => DiscountUsageEntity(
      discountId: item.discountId,
      discountName: item.discountName,
      usageCount: item.usageCount,
      totalDiscountAmount: item.totalDiscountAmount,
      revenueGenerated: item.revenueGenerated,
    )).toList();
  }

  @override
  Future<List<HourlySalesEntity>> getHourlySales(
    String vendorId,
    DateTime date,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final hourlySales = MockDataSource.getHourlySales(vendorId, date);
    return hourlySales.map((item) => HourlySalesEntity(
      hour: item.hour,
      revenue: item.revenue,
      orderCount: item.orderCount,
    )).toList();
  }

  @override
  Future<Map<String, dynamic>> getSalesSummary(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 350));
    
    final summary = MockDataSource.getSalesSummary(vendorId);
    return {
      'totalRevenue': summary['totalRevenue'],
      'totalOrders': summary['totalOrders'],
      'averageOrderValue': summary['averageOrderValue'],
      'bestSellingItem': summary['bestSellingItem'],
      'peakHour': summary['peakHour'],
      'mostUsedDiscount': summary['mostUsedDiscount'],
      'revenueGrowth': summary['revenueGrowth'],
    };
  }

  SalesReportEntity _convertToEntity(SalesReportModel model) {
    return SalesReportEntity(
      reportId: model.reportId,
      vendorId: model.vendorId,
      reportDate: model.reportDate,
      totalRevenue: model.totalRevenue,
      totalOrders: model.totalOrders,
      averageOrderValue: model.averageOrderValue,
      topSellingItems: model.topSellingItems.map((item) => SalesItemEntity(
        menuItemId: item.menuItemId,
        name: item.name,
        quantitySold: item.quantitySold,
        totalRevenue: item.totalRevenue,
        orderCount: item.orderCount,
      )).toList(),
      discountUsage: model.discountUsage.map((item) => DiscountUsageEntity(
        discountId: item.discountId,
        discountName: item.discountName,
        usageCount: item.usageCount,
        totalDiscountAmount: item.totalDiscountAmount,
        revenueGenerated: item.revenueGenerated,
      )).toList(),
      hourlySales: model.hourlySales.map((item) => HourlySalesEntity(
        hour: item.hour,
        revenue: item.revenue,
        orderCount: item.orderCount,
      )).toList(),
    );
  }
}
