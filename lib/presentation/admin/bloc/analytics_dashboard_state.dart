import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/analytics_entity.dart';

abstract class AnalyticsDashboardState extends Equatable {
  const AnalyticsDashboardState();

  @override
  List<Object?> get props => [];
}

class AnalyticsDashboardInitial extends AnalyticsDashboardState {
  const AnalyticsDashboardInitial();
}

class AnalyticsDashboardLoading extends AnalyticsDashboardState {
  const AnalyticsDashboardLoading();
}

class AnalyticsLoaded extends AnalyticsDashboardState {
  final AnalyticsEntity analytics;

  const AnalyticsLoaded({required this.analytics});

  @override
  List<Object?> get props => [analytics];
}

class SystemOverviewLoaded extends AnalyticsDashboardState {
  final SystemOverview overview;

  const SystemOverviewLoaded({required this.overview});

  @override
  List<Object?> get props => [overview];
}

class SalesAnalyticsLoaded extends AnalyticsDashboardState {
  final SalesAnalytics sales;

  const SalesAnalyticsLoaded({required this.sales});

  @override
  List<Object?> get props => [sales];
}

class UserAnalyticsLoaded extends AnalyticsDashboardState {
  final UserAnalytics users;

  const UserAnalyticsLoaded({required this.users});

  @override
  List<Object?> get props => [users];
}

class VendorAnalyticsLoaded extends AnalyticsDashboardState {
  final VendorAnalytics vendors;

  const VendorAnalyticsLoaded({required this.vendors});

  @override
  List<Object?> get props => [vendors];
}

class WalletAnalyticsLoaded extends AnalyticsDashboardState {
  final WalletAnalytics wallet;

  const WalletAnalyticsLoaded({required this.wallet});

  @override
  List<Object?> get props => [wallet];
}

class OrderAnalyticsLoaded extends AnalyticsDashboardState {
  final OrderAnalytics orders;

  const OrderAnalyticsLoaded({required this.orders});

  @override
  List<Object?> get props => [orders];
}

class PeakHourAnalysisLoaded extends AnalyticsDashboardState {
  final List<PeakHourData> peakHours;

  const PeakHourAnalysisLoaded({required this.peakHours});

  @override
  List<Object?> get props => [peakHours];
}

class DailyTrendsLoaded extends AnalyticsDashboardState {
  final List<DailyTrend> trends;

  const DailyTrendsLoaded({required this.trends});

  @override
  List<Object?> get props => [trends];
}

class CategoryPerformanceLoaded extends AnalyticsDashboardState {
  final List<CategoryPerformance> categories;

  const CategoryPerformanceLoaded({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class PaymentMethodAnalyticsLoaded extends AnalyticsDashboardState {
  final List<PaymentMethodAnalytics> paymentMethods;

  const PaymentMethodAnalyticsLoaded({required this.paymentMethods});

  @override
  List<Object?> get props => [paymentMethods];
}

class TopVendorsLoaded extends AnalyticsDashboardState {
  final List<TopVendor> vendors;

  const TopVendorsLoaded({required this.vendors});

  @override
  List<Object?> get props => [vendors];
}

class RecentWalletTransactionsLoaded extends AnalyticsDashboardState {
  final List<WalletTransaction> transactions;

  const RecentWalletTransactionsLoaded({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}

class RealTimeDashboardDataLoaded extends AnalyticsDashboardState {
  final Map<String, dynamic> data;

  const RealTimeDashboardDataLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class CustomReportLoaded extends AnalyticsDashboardState {
  final Map<String, dynamic> report;

  const CustomReportLoaded({required this.report});

  @override
  List<Object?> get props => [report];
}

class AnalyticsDataExported extends AnalyticsDashboardState {
  final String downloadUrl;
  final String format;

  const AnalyticsDataExported({
    required this.downloadUrl,
    required this.format,
  });

  @override
  List<Object?> get props => [downloadUrl, format];
}

class AnalyticsInsightsLoaded extends AnalyticsDashboardState {
  final Map<String, dynamic> insights;

  const AnalyticsInsightsLoaded({required this.insights});

  @override
  List<Object?> get props => [insights];
}

class PeriodComparisonLoaded extends AnalyticsDashboardState {
  final Map<String, dynamic> comparison;

  const PeriodComparisonLoaded({required this.comparison});

  @override
  List<Object?> get props => [comparison];
}

class AnalyticsOperationFailure extends AnalyticsDashboardState {
  final String error;

  const AnalyticsOperationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
