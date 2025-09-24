part of 'sales_report_bloc.dart';

abstract class SalesReportEvent extends Equatable {
  const SalesReportEvent();

  @override
  List<Object> get props => [];
}

class LoadDailyReport extends SalesReportEvent {
  final String vendorId;
  final DateTime date;

  const LoadDailyReport({
    required this.vendorId,
    required this.date,
  });

  @override
  List<Object> get props => [vendorId, date];
}

class LoadWeeklyReport extends SalesReportEvent {
  final String vendorId;
  final DateTime weekStart;

  const LoadWeeklyReport({
    required this.vendorId,
    required this.weekStart,
  });

  @override
  List<Object> get props => [vendorId, weekStart];
}

class LoadMonthlyReport extends SalesReportEvent {
  final String vendorId;
  final DateTime month;

  const LoadMonthlyReport({
    required this.vendorId,
    required this.month,
  });

  @override
  List<Object> get props => [vendorId, month];
}

class LoadSalesSummary extends SalesReportEvent {
  final String vendorId;

  const LoadSalesSummary({required this.vendorId});

  @override
  List<Object> get props => [vendorId];
}

class LoadTopSellingItems extends SalesReportEvent {
  final String vendorId;
  final DateTime startDate;
  final DateTime endDate;
  final int limit;

  const LoadTopSellingItems({
    required this.vendorId,
    required this.startDate,
    required this.endDate,
    required this.limit,
  });

  @override
  List<Object> get props => [vendorId, startDate, endDate, limit];
}

class LoadDiscountUsage extends SalesReportEvent {
  final String vendorId;
  final DateTime startDate;
  final DateTime endDate;

  const LoadDiscountUsage({
    required this.vendorId,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [vendorId, startDate, endDate];
}

class LoadHourlySales extends SalesReportEvent {
  final String vendorId;
  final DateTime date;

  const LoadHourlySales({
    required this.vendorId,
    required this.date,
  });

  @override
  List<Object> get props => [vendorId, date];
}
