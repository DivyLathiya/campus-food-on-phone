import 'package:equatable/equatable.dart';

class SalesReportEntity extends Equatable {
  final String reportId;
  final String vendorId;
  final DateTime reportDate;
  final double totalRevenue;
  final int totalOrders;
  final double averageOrderValue;
  final List<SalesItemEntity> topSellingItems;
  final List<DiscountUsageEntity> discountUsage;
  final List<HourlySalesEntity> hourlySales;

  const SalesReportEntity({
    required this.reportId,
    required this.vendorId,
    required this.reportDate,
    required this.totalRevenue,
    required this.totalOrders,
    required this.averageOrderValue,
    required this.topSellingItems,
    required this.discountUsage,
    required this.hourlySales,
  });

  @override
  List<Object?> get props {
    return [
      reportId,
      vendorId,
      reportDate,
      totalRevenue,
      totalOrders,
      averageOrderValue,
      topSellingItems,
      discountUsage,
      hourlySales,
    ];
  }
}

class SalesItemEntity extends Equatable {
  final String menuItemId;
  final String name;
  final int quantitySold;
  final double totalRevenue;
  final int orderCount;

  const SalesItemEntity({
    required this.menuItemId,
    required this.name,
    required this.quantitySold,
    required this.totalRevenue,
    required this.orderCount,
  });

  @override
  List<Object?> get props {
    return [
      menuItemId,
      name,
      quantitySold,
      totalRevenue,
      orderCount,
    ];
  }
}

class DiscountUsageEntity extends Equatable {
  final String discountId;
  final String discountName;
  final int usageCount;
  final double totalDiscountAmount;
  final double revenueGenerated;

  const DiscountUsageEntity({
    required this.discountId,
    required this.discountName,
    required this.usageCount,
    required this.totalDiscountAmount,
    required this.revenueGenerated,
  });

  @override
  List<Object?> get props {
    return [
      discountId,
      discountName,
      usageCount,
      totalDiscountAmount,
      revenueGenerated,
    ];
  }
}

class HourlySalesEntity extends Equatable {
  final int hour;
  final double revenue;
  final int orderCount;

  const HourlySalesEntity({
    required this.hour,
    required this.revenue,
    required this.orderCount,
  });

  @override
  List<Object?> get props {
    return [hour, revenue, orderCount];
  }
}
