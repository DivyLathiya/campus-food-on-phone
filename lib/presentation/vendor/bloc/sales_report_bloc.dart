import 'package:bloc/bloc.dart';
import 'package:campus_food_app/domain/entities/sales_report_entity.dart';
import 'package:campus_food_app/domain/repositories/sales_report_repository.dart';
import 'package:equatable/equatable.dart';

part 'sales_report_event.dart';
part 'sales_report_state.dart';

class SalesReportBloc extends Bloc<SalesReportEvent, SalesReportState> {
  final SalesReportRepository salesReportRepository;

  SalesReportBloc({required this.salesReportRepository}) : super(SalesReportInitial()) {
    on<LoadDailyReport>(_onLoadDailyReport);
    on<LoadWeeklyReport>(_onLoadWeeklyReport);
    on<LoadMonthlyReport>(_onLoadMonthlyReport);
    on<LoadSalesSummary>(_onLoadSalesSummary);
    on<LoadTopSellingItems>(_onLoadTopSellingItems);
    on<LoadDiscountUsage>(_onLoadDiscountUsage);
    on<LoadHourlySales>(_onLoadHourlySales);
  }

  Future<void> _onLoadDailyReport(
    LoadDailyReport event,
    Emitter<SalesReportState> emit,
  ) async {
    emit(SalesReportLoading());
    try {
      final report = await salesReportRepository.getDailyReport(event.vendorId, event.date);
      emit(DailyReportLoaded(report: report));
    } catch (e) {
      emit(SalesReportError(message: 'Failed to load daily report: ${e.toString()}'));
    }
  }

  Future<void> _onLoadWeeklyReport(
    LoadWeeklyReport event,
    Emitter<SalesReportState> emit,
  ) async {
    emit(SalesReportLoading());
    try {
      final report = await salesReportRepository.getWeeklyReport(event.vendorId, event.weekStart);
      emit(WeeklyReportLoaded(report: report));
    } catch (e) {
      emit(SalesReportError(message: 'Failed to load weekly report: ${e.toString()}'));
    }
  }

  Future<void> _onLoadMonthlyReport(
    LoadMonthlyReport event,
    Emitter<SalesReportState> emit,
  ) async {
    emit(SalesReportLoading());
    try {
      final report = await salesReportRepository.getMonthlyReport(event.vendorId, event.month);
      emit(MonthlyReportLoaded(report: report));
    } catch (e) {
      emit(SalesReportError(message: 'Failed to load monthly report: ${e.toString()}'));
    }
  }

  Future<void> _onLoadSalesSummary(
    LoadSalesSummary event,
    Emitter<SalesReportState> emit,
  ) async {
    emit(SalesReportLoading());
    try {
      final summary = await salesReportRepository.getSalesSummary(event.vendorId);
      emit(SalesSummaryLoaded(summary: summary));
    } catch (e) {
      emit(SalesReportError(message: 'Failed to load sales summary: ${e.toString()}'));
    }
  }

  Future<void> _onLoadTopSellingItems(
    LoadTopSellingItems event,
    Emitter<SalesReportState> emit,
  ) async {
    emit(SalesReportLoading());
    try {
      final items = await salesReportRepository.getTopSellingItems(
        event.vendorId,
        event.startDate,
        event.endDate,
        event.limit,
      );
      emit(TopSellingItemsLoaded(items: items));
    } catch (e) {
      emit(SalesReportError(message: 'Failed to load top selling items: ${e.toString()}'));
    }
  }

  Future<void> _onLoadDiscountUsage(
    LoadDiscountUsage event,
    Emitter<SalesReportState> emit,
  ) async {
    emit(SalesReportLoading());
    try {
      final discountUsage = await salesReportRepository.getDiscountUsage(
        event.vendorId,
        event.startDate,
        event.endDate,
      );
      emit(DiscountUsageLoaded(discountUsage: discountUsage));
    } catch (e) {
      emit(SalesReportError(message: 'Failed to load discount usage: ${e.toString()}'));
    }
  }

  Future<void> _onLoadHourlySales(
    LoadHourlySales event,
    Emitter<SalesReportState> emit,
  ) async {
    emit(SalesReportLoading());
    try {
      final hourlySales = await salesReportRepository.getHourlySales(
        event.vendorId,
        event.date,
      );
      emit(HourlySalesLoaded(hourlySales: hourlySales));
    } catch (e) {
      emit(SalesReportError(message: 'Failed to load hourly sales: ${e.toString()}'));
    }
  }
}
