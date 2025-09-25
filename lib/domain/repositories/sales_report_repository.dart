import 'package:campus_food_app/domain/entities/sales_report_entity.dart';

abstract class SalesReportRepository {
  Future<SalesReportEntity> getDailyReport(String vendorId, DateTime date);
  Future<SalesReportEntity> getWeeklyReport(String vendorId, DateTime weekStart);
  Future<SalesReportEntity> getMonthlyReport(String vendorId, DateTime month);
  Future<List<SalesReportEntity>> getReportsByDateRange(
    String vendorId,
    DateTime startDate,
    DateTime endDate,
  );
  Future<List<SalesItemEntity>> getTopSellingItems(
    String vendorId,
    DateTime startDate,
    DateTime endDate,
    int limit,
  );
  Future<List<DiscountUsageEntity>> getDiscountUsage(
    String vendorId,
    DateTime startDate,
    DateTime endDate,
  );
  Future<List<HourlySalesEntity>> getHourlySales(
    String vendorId,
    DateTime date,
  );
  Future<Map<String, dynamic>> getSalesSummary(String vendorId);
}
