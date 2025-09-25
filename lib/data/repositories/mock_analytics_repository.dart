import 'package:campus_food_app/data/datasources/mock_data_source.dart';
import 'package:campus_food_app/domain/entities/analytics_entity.dart';
import 'package:campus_food_app/domain/repositories/analytics_repository.dart';

class MockAnalyticsRepository implements AnalyticsRepository {
  @override
  Future<AnalyticsEntity> getAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return MockDataSource.getAnalytics(period: period, startDate: startDate, endDate: endDate);
  }

  @override
  Future<SystemOverview> getSystemOverview() async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    return MockDataSource.getSystemOverview();
  }

  @override
  Future<SalesAnalytics> getSalesAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return MockDataSource.getSalesAnalytics(period: period, startDate: startDate, endDate: endDate);
  }

  @override
  Future<UserAnalytics> getUserAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return MockDataSource.getUserAnalytics(period: period, startDate: startDate, endDate: endDate);
  }

  @override
  Future<VendorAnalytics> getVendorAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return MockDataSource.getVendorAnalytics(period: period, startDate: startDate, endDate: endDate);
  }

  @override
  Future<WalletAnalytics> getWalletAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return MockDataSource.getWalletAnalytics(period: period, startDate: startDate, endDate: endDate);
  }

  @override
  Future<OrderAnalytics> getOrderAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return MockDataSource.getOrderAnalytics(period: period, startDate: startDate, endDate: endDate);
  }

  @override
  Future<List<PeakHourData>> getPeakHourAnalysis({
    required String period,
    String? startDate,
    String? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    return MockDataSource.getPeakHourAnalysis(period: period, startDate: startDate, endDate: endDate);
  }

  @override
  Future<List<DailyTrend>> getDailyTrends({
    required String period,
    String? startDate,
    String? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    return MockDataSource.getDailyTrends(period: period, startDate: startDate, endDate: endDate);
  }

  @override
  Future<List<CategoryPerformance>> getCategoryPerformance({
    required String period,
    String? startDate,
    String? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    return MockDataSource.getCategoryPerformance(period: period, startDate: startDate, endDate: endDate);
  }

  @override
  Future<List<PaymentMethodAnalytics>> getPaymentMethodAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    return MockDataSource.getPaymentMethodAnalytics(period: period, startDate: startDate, endDate: endDate);
  }

  @override
  Future<List<TopVendor>> getTopVendors({
    required String period,
    int limit = 10,
    String? startDate,
    String? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return MockDataSource.getTopVendors(period: period, limit: limit, startDate: startDate, endDate: endDate);
  }

  @override
  Future<List<WalletTransaction>> getRecentWalletTransactions({
    int limit = 50,
    String? userId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    return MockDataSource.getRecentWalletTransactions(limit: limit, userId: userId);
  }

  @override
  Future<Map<String, dynamic>> getRealTimeDashboardData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    return MockDataSource.getRealTimeDashboardData();
  }

  @override
  Future<Map<String, dynamic>> getCustomReport({
    required List<String> metrics,
    required String period,
    String? startDate,
    String? endDate,
    Map<String, dynamic>? filters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    return MockDataSource.getCustomReport(
      metrics: metrics,
      period: period,
      startDate: startDate,
      endDate: endDate,
      filters: filters,
    );
  }

  @override
  Future<String> exportAnalyticsData({
    required String format,
    required String period,
    String? startDate,
    String? endDate,
    List<String>? metrics,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    return MockDataSource.exportAnalyticsData(
      format: format,
      period: period,
      startDate: startDate,
      endDate: endDate,
      metrics: metrics,
    );
  }

  @override
  Future<Map<String, dynamic>> getAnalyticsInsights() async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    return MockDataSource.getAnalyticsInsights();
  }

  @override
  Future<Map<String, dynamic>> comparePeriods({
    required String currentPeriod,
    required String previousPeriod,
    List<String>? metrics,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    return MockDataSource.comparePeriods(
      currentPeriod: currentPeriod,
      previousPeriod: previousPeriod,
    );
  }
}
