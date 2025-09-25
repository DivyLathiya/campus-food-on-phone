import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/domain/repositories/analytics_repository.dart';
import 'package:campus_food_app/presentation/admin/bloc/analytics_dashboard_event.dart';
import 'package:campus_food_app/presentation/admin/bloc/analytics_dashboard_state.dart';

class AnalyticsDashboardBloc extends Bloc<AnalyticsDashboardEvent, AnalyticsDashboardState> {
  final AnalyticsRepository analyticsRepository;

  AnalyticsDashboardBloc({required this.analyticsRepository}) : super(const AnalyticsDashboardInitial()) {
    on<LoadAnalytics>(_onLoadAnalytics);
    on<LoadSystemOverview>(_onLoadSystemOverview);
    on<LoadSalesAnalytics>(_onLoadSalesAnalytics);
    on<LoadUserAnalytics>(_onLoadUserAnalytics);
    on<LoadVendorAnalytics>(_onLoadVendorAnalytics);
    on<LoadWalletAnalytics>(_onLoadWalletAnalytics);
    on<LoadOrderAnalytics>(_onLoadOrderAnalytics);
    on<LoadPeakHourAnalysis>(_onLoadPeakHourAnalysis);
    on<LoadDailyTrends>(_onLoadDailyTrends);
    on<LoadCategoryPerformance>(_onLoadCategoryPerformance);
    on<LoadPaymentMethodAnalytics>(_onLoadPaymentMethodAnalytics);
    on<LoadTopVendors>(_onLoadTopVendors);
    on<LoadRecentWalletTransactions>(_onLoadRecentWalletTransactions);
    on<LoadRealTimeDashboardData>(_onLoadRealTimeDashboardData);
    on<LoadCustomReport>(_onLoadCustomReport);
    on<ExportAnalyticsData>(_onExportAnalyticsData);
    on<LoadAnalyticsInsights>(_onLoadAnalyticsInsights);
    on<ComparePeriods>(_onComparePeriods);
    on<RefreshAnalytics>(_onRefreshAnalytics);
  }

  Future<void> _onLoadAnalytics(
    LoadAnalytics event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    emit(const AnalyticsDashboardLoading());
    
    try {
      final analytics = await analyticsRepository.getAnalytics(
        period: event.period,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      
      emit(AnalyticsLoaded(analytics: analytics));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadSystemOverview(
    LoadSystemOverview event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final overview = await analyticsRepository.getSystemOverview();
      
      emit(SystemOverviewLoaded(overview: overview));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadSalesAnalytics(
    LoadSalesAnalytics event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final sales = await analyticsRepository.getSalesAnalytics(
        period: event.period,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      
      emit(SalesAnalyticsLoaded(sales: sales));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadUserAnalytics(
    LoadUserAnalytics event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final users = await analyticsRepository.getUserAnalytics(
        period: event.period,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      
      emit(UserAnalyticsLoaded(users: users));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadVendorAnalytics(
    LoadVendorAnalytics event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final vendors = await analyticsRepository.getVendorAnalytics(
        period: event.period,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      
      emit(VendorAnalyticsLoaded(vendors: vendors));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadWalletAnalytics(
    LoadWalletAnalytics event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final wallet = await analyticsRepository.getWalletAnalytics(
        period: event.period,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      
      emit(WalletAnalyticsLoaded(wallet: wallet));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadOrderAnalytics(
    LoadOrderAnalytics event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final orders = await analyticsRepository.getOrderAnalytics(
        period: event.period,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      
      emit(OrderAnalyticsLoaded(orders: orders));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadPeakHourAnalysis(
    LoadPeakHourAnalysis event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final peakHours = await analyticsRepository.getPeakHourAnalysis(
        period: event.period,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      
      emit(PeakHourAnalysisLoaded(peakHours: peakHours));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadDailyTrends(
    LoadDailyTrends event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final trends = await analyticsRepository.getDailyTrends(
        period: event.period,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      
      emit(DailyTrendsLoaded(trends: trends));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadCategoryPerformance(
    LoadCategoryPerformance event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final categories = await analyticsRepository.getCategoryPerformance(
        period: event.period,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      
      emit(CategoryPerformanceLoaded(categories: categories));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadPaymentMethodAnalytics(
    LoadPaymentMethodAnalytics event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final paymentMethods = await analyticsRepository.getPaymentMethodAnalytics(
        period: event.period,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      
      emit(PaymentMethodAnalyticsLoaded(paymentMethods: paymentMethods));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadTopVendors(
    LoadTopVendors event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final vendors = await analyticsRepository.getTopVendors(
        period: event.period,
        limit: event.limit,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      
      emit(TopVendorsLoaded(vendors: vendors));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadRecentWalletTransactions(
    LoadRecentWalletTransactions event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final transactions = await analyticsRepository.getRecentWalletTransactions(
        limit: event.limit,
        userId: event.userId,
      );
      
      emit(RecentWalletTransactionsLoaded(transactions: transactions));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadRealTimeDashboardData(
    LoadRealTimeDashboardData event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final data = await analyticsRepository.getRealTimeDashboardData();
      
      emit(RealTimeDashboardDataLoaded(data: data));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadCustomReport(
    LoadCustomReport event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final report = await analyticsRepository.getCustomReport(
        metrics: event.metrics,
        period: event.period,
        startDate: event.startDate,
        endDate: event.endDate,
        filters: event.filters,
      );
      
      emit(CustomReportLoaded(report: report));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onExportAnalyticsData(
    ExportAnalyticsData event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final downloadUrl = await analyticsRepository.exportAnalyticsData(
        format: event.format,
        period: event.period,
        startDate: event.startDate,
        endDate: event.endDate,
        metrics: event.metrics,
      );
      
      emit(AnalyticsDataExported(
        downloadUrl: downloadUrl,
        format: event.format,
      ));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadAnalyticsInsights(
    LoadAnalyticsInsights event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final insights = await analyticsRepository.getAnalyticsInsights();
      
      emit(AnalyticsInsightsLoaded(insights: insights));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onComparePeriods(
    ComparePeriods event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    try {
      final comparison = await analyticsRepository.comparePeriods(
        currentPeriod: event.currentPeriod,
        previousPeriod: event.previousPeriod,
        metrics: event.metrics,
      );
      
      emit(PeriodComparisonLoaded(comparison: comparison));
    } catch (e) {
      emit(AnalyticsOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onRefreshAnalytics(
    RefreshAnalytics event,
    Emitter<AnalyticsDashboardState> emit,
  ) async {
    add(const LoadAnalytics(period: 'daily'));
  }
}
