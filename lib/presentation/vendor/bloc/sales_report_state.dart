part of 'sales_report_bloc.dart';

abstract class SalesReportState extends Equatable {
  const SalesReportState();

  @override
  List<Object> get props => [];
}

class SalesReportInitial extends SalesReportState {}

class SalesReportLoading extends SalesReportState {}

class DailyReportLoaded extends SalesReportState {
  final SalesReportEntity report;

  const DailyReportLoaded({required this.report});

  @override
  List<Object> get props => [report];
}

class WeeklyReportLoaded extends SalesReportState {
  final SalesReportEntity report;

  const WeeklyReportLoaded({required this.report});

  @override
  List<Object> get props => [report];
}

class MonthlyReportLoaded extends SalesReportState {
  final SalesReportEntity report;

  const MonthlyReportLoaded({required this.report});

  @override
  List<Object> get props => [report];
}

class SalesSummaryLoaded extends SalesReportState {
  final Map<String, dynamic> summary;

  const SalesSummaryLoaded({required this.summary});

  @override
  List<Object> get props => [summary];
}

class TopSellingItemsLoaded extends SalesReportState {
  final List<SalesItemEntity> items;

  const TopSellingItemsLoaded({required this.items});

  @override
  List<Object> get props => [items];
}

class DiscountUsageLoaded extends SalesReportState {
  final List<DiscountUsageEntity> discountUsage;

  const DiscountUsageLoaded({required this.discountUsage});

  @override
  List<Object> get props => [discountUsage];
}

class HourlySalesLoaded extends SalesReportState {
  final List<HourlySalesEntity> hourlySales;

  const HourlySalesLoaded({required this.hourlySales});

  @override
  List<Object> get props => [hourlySales];
}

class SalesReportError extends SalesReportState {
  final String message;

  const SalesReportError({required this.message});

  @override
  List<Object> get props => [message];
}
