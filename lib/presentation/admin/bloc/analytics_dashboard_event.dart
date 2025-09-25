import 'package:equatable/equatable.dart';

abstract class AnalyticsDashboardEvent extends Equatable {
  const AnalyticsDashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadAnalytics extends AnalyticsDashboardEvent {
  final String period;
  final String? startDate;
  final String? endDate;

  const LoadAnalytics({
    required this.period,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [period, startDate, endDate];
}

class LoadSystemOverview extends AnalyticsDashboardEvent {
  const LoadSystemOverview();
}

class LoadSalesAnalytics extends AnalyticsDashboardEvent {
  final String period;
  final String? startDate;
  final String? endDate;

  const LoadSalesAnalytics({
    required this.period,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [period, startDate, endDate];
}

class LoadUserAnalytics extends AnalyticsDashboardEvent {
  final String period;
  final String? startDate;
  final String? endDate;

  const LoadUserAnalytics({
    required this.period,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [period, startDate, endDate];
}

class LoadVendorAnalytics extends AnalyticsDashboardEvent {
  final String period;
  final String? startDate;
  final String? endDate;

  const LoadVendorAnalytics({
    required this.period,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [period, startDate, endDate];
}

class LoadWalletAnalytics extends AnalyticsDashboardEvent {
  final String period;
  final String? startDate;
  final String? endDate;

  const LoadWalletAnalytics({
    required this.period,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [period, startDate, endDate];
}

class LoadOrderAnalytics extends AnalyticsDashboardEvent {
  final String period;
  final String? startDate;
  final String? endDate;

  const LoadOrderAnalytics({
    required this.period,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [period, startDate, endDate];
}

class LoadPeakHourAnalysis extends AnalyticsDashboardEvent {
  final String period;
  final String? startDate;
  final String? endDate;

  const LoadPeakHourAnalysis({
    required this.period,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [period, startDate, endDate];
}

class LoadDailyTrends extends AnalyticsDashboardEvent {
  final String period;
  final String? startDate;
  final String? endDate;

  const LoadDailyTrends({
    required this.period,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [period, startDate, endDate];
}

class LoadCategoryPerformance extends AnalyticsDashboardEvent {
  final String period;
  final String? startDate;
  final String? endDate;

  const LoadCategoryPerformance({
    required this.period,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [period, startDate, endDate];
}

class LoadPaymentMethodAnalytics extends AnalyticsDashboardEvent {
  final String period;
  final String? startDate;
  final String? endDate;

  const LoadPaymentMethodAnalytics({
    required this.period,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [period, startDate, endDate];
}

class LoadTopVendors extends AnalyticsDashboardEvent {
  final String period;
  final int limit;
  final String? startDate;
  final String? endDate;

  const LoadTopVendors({
    required this.period,
    this.limit = 10,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [period, limit, startDate, endDate];
}

class LoadRecentWalletTransactions extends AnalyticsDashboardEvent {
  final int limit;
  final String? userId;

  const LoadRecentWalletTransactions({
    this.limit = 50,
    this.userId,
  });

  @override
  List<Object?> get props => [limit, userId];
}

class LoadRealTimeDashboardData extends AnalyticsDashboardEvent {
  const LoadRealTimeDashboardData();
}

class LoadCustomReport extends AnalyticsDashboardEvent {
  final List<String> metrics;
  final String period;
  final String? startDate;
  final String? endDate;
  final Map<String, dynamic>? filters;

  const LoadCustomReport({
    required this.metrics,
    required this.period,
    this.startDate,
    this.endDate,
    this.filters,
  });

  @override
  List<Object?> get props => [metrics, period, startDate, endDate, filters];
}

class ExportAnalyticsData extends AnalyticsDashboardEvent {
  final String format; // 'csv', 'json', 'pdf'
  final String period;
  final String? startDate;
  final String? endDate;
  final List<String>? metrics;

  const ExportAnalyticsData({
    required this.format,
    required this.period,
    this.startDate,
    this.endDate,
    this.metrics,
  });

  @override
  List<Object?> get props => [format, period, startDate, endDate, metrics];
}

class LoadAnalyticsInsights extends AnalyticsDashboardEvent {
  const LoadAnalyticsInsights();
}

class ComparePeriods extends AnalyticsDashboardEvent {
  final String currentPeriod;
  final String previousPeriod;
  final List<String>? metrics;

  const ComparePeriods({
    required this.currentPeriod,
    required this.previousPeriod,
    this.metrics,
  });

  @override
  List<Object?> get props => [currentPeriod, previousPeriod, metrics];
}

class RefreshAnalytics extends AnalyticsDashboardEvent {
  const RefreshAnalytics();
}
