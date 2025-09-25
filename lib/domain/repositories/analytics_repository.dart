import 'package:campus_food_app/domain/entities/analytics_entity.dart';

abstract class AnalyticsRepository {
  // Get analytics for a specific period
  Future<AnalyticsEntity> getAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  });

  // Get system overview
  Future<SystemOverview> getSystemOverview();

  // Get sales analytics
  Future<SalesAnalytics> getSalesAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  });

  // Get user analytics
  Future<UserAnalytics> getUserAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  });

  // Get vendor analytics
  Future<VendorAnalytics> getVendorAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  });

  // Get wallet analytics
  Future<WalletAnalytics> getWalletAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  });

  // Get order analytics
  Future<OrderAnalytics> getOrderAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  });

  // Get peak hour analysis
  Future<List<PeakHourData>> getPeakHourAnalysis({
    required String period,
    String? startDate,
    String? endDate,
  });

  // Get daily trends
  Future<List<DailyTrend>> getDailyTrends({
    required String period,
    String? startDate,
    String? endDate,
  });

  // Get category performance
  Future<List<CategoryPerformance>> getCategoryPerformance({
    required String period,
    String? startDate,
    String? endDate,
  });

  // Get payment method analytics
  Future<List<PaymentMethodAnalytics>> getPaymentMethodAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  });

  // Get top vendors
  Future<List<TopVendor>> getTopVendors({
    required String period,
    int limit = 10,
    String? startDate,
    String? endDate,
  });

  // Get recent wallet transactions
  Future<List<WalletTransaction>> getRecentWalletTransactions({
    int limit = 50,
    String? userId,
  });

  // Get real-time dashboard data
  Future<Map<String, dynamic>> getRealTimeDashboardData();

  // Get custom report
  Future<Map<String, dynamic>> getCustomReport({
    required List<String> metrics,
    required String period,
    String? startDate,
    String? endDate,
    Map<String, dynamic>? filters,
  });

  // Export analytics data
  Future<String> exportAnalyticsData({
    required String format, // 'csv', 'json', 'pdf'
    required String period,
    String? startDate,
    String? endDate,
    List<String>? metrics,
  });

  // Get analytics insights and recommendations
  Future<Map<String, dynamic>> getAnalyticsInsights();

  // Compare periods
  Future<Map<String, dynamic>> comparePeriods({
    required String currentPeriod,
    required String previousPeriod,
    List<String>? metrics,
  });
}
