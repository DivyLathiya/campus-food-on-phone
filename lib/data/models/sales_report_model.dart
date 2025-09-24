import 'package:campus_food_app/domain/entities/sales_report_entity.dart';

class SalesReportModel {
  final String reportId;
  final String vendorId;
  final DateTime reportDate;
  final double totalRevenue;
  final int totalOrders;
  final double averageOrderValue;
  final List<SalesItemModel> topSellingItems;
  final List<DiscountUsageModel> discountUsage;
  final List<HourlySalesModel> hourlySales;

  SalesReportModel({
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

  factory SalesReportModel.fromEntity(SalesReportEntity entity) {
    return SalesReportModel(
      reportId: entity.reportId,
      vendorId: entity.vendorId,
      reportDate: entity.reportDate,
      totalRevenue: entity.totalRevenue,
      totalOrders: entity.totalOrders,
      averageOrderValue: entity.averageOrderValue,
      topSellingItems: entity.topSellingItems
          .map((item) => SalesItemModel.fromEntity(item))
          .toList(),
      discountUsage: entity.discountUsage
          .map((usage) => DiscountUsageModel.fromEntity(usage))
          .toList(),
      hourlySales: entity.hourlySales
          .map((hourly) => HourlySalesModel.fromEntity(hourly))
          .toList(),
    );
  }

  SalesReportEntity toEntity() {
    return SalesReportEntity(
      reportId: reportId,
      vendorId: vendorId,
      reportDate: reportDate,
      totalRevenue: totalRevenue,
      totalOrders: totalOrders,
      averageOrderValue: averageOrderValue,
      topSellingItems: topSellingItems
          .map((item) => item.toEntity())
          .toList(),
      discountUsage: discountUsage
          .map((usage) => usage.toEntity())
          .toList(),
      hourlySales: hourlySales
          .map((hourly) => hourly.toEntity())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reportId': reportId,
      'vendorId': vendorId,
      'reportDate': reportDate.toIso8601String(),
      'totalRevenue': totalRevenue,
      'totalOrders': totalOrders,
      'averageOrderValue': averageOrderValue,
      'topSellingItems': topSellingItems.map((item) => item.toJson()).toList(),
      'discountUsage': discountUsage.map((usage) => usage.toJson()).toList(),
      'hourlySales': hourlySales.map((hourly) => hourly.toJson()).toList(),
    };
  }

  factory SalesReportModel.fromJson(Map<String, dynamic> json) {
    return SalesReportModel(
      reportId: json['reportId'],
      vendorId: json['vendorId'],
      reportDate: DateTime.parse(json['reportDate']),
      totalRevenue: json['totalRevenue'].toDouble(),
      totalOrders: json['totalOrders'],
      averageOrderValue: json['averageOrderValue'].toDouble(),
      topSellingItems: (json['topSellingItems'] as List)
          .map((item) => SalesItemModel.fromJson(item))
          .toList(),
      discountUsage: (json['discountUsage'] as List)
          .map((usage) => DiscountUsageModel.fromJson(usage))
          .toList(),
      hourlySales: (json['hourlySales'] as List)
          .map((hourly) => HourlySalesModel.fromJson(hourly))
          .toList(),
    );
  }
}

class SalesItemModel {
  final String itemId;
  final String itemName;
  final int quantitySold;
  final double totalRevenue;
  final int orderCount;

  SalesItemModel({
    required this.itemId,
    required this.itemName,
    required this.quantitySold,
    required this.totalRevenue,
    required this.orderCount,
  });

  factory SalesItemModel.fromEntity(SalesItemEntity entity) {
    return SalesItemModel(
      itemId: entity.menuItemId,
      itemName: entity.name,
      quantitySold: entity.quantitySold,
      totalRevenue: entity.totalRevenue,
      orderCount: entity.orderCount,
    );
  }

  SalesItemEntity toEntity() {
    return SalesItemEntity(
      menuItemId: itemId,
      name: itemName,
      quantitySold: quantitySold,
      totalRevenue: totalRevenue,
      orderCount: orderCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'quantitySold': quantitySold,
      'totalRevenue': totalRevenue,
      'orderCount': orderCount,
    };
  }

  factory SalesItemModel.fromJson(Map<String, dynamic> json) {
    return SalesItemModel(
      itemId: json['itemId'],
      itemName: json['itemName'],
      quantitySold: json['quantitySold'],
      totalRevenue: json['totalRevenue'].toDouble(),
      orderCount: json['orderCount'],
    );
  }

  // Getters for compatibility with entity fields
  String get menuItemId => itemId;
  String get name => itemName;
}

class DiscountUsageModel {
  final String discountId;
  final String discountTitle;
  final int usageCount;
  final double totalDiscountAmount;
  final double revenueGenerated;

  DiscountUsageModel({
    required this.discountId,
    required this.discountTitle,
    required this.usageCount,
    required this.totalDiscountAmount,
    required this.revenueGenerated,
  });

  factory DiscountUsageModel.fromEntity(DiscountUsageEntity entity) {
    return DiscountUsageModel(
      discountId: entity.discountId,
      discountTitle: entity.discountName,
      usageCount: entity.usageCount,
      totalDiscountAmount: entity.totalDiscountAmount,
      revenueGenerated: entity.revenueGenerated,
    );
  }

  DiscountUsageEntity toEntity() {
    return DiscountUsageEntity(
      discountId: discountId,
      discountName: discountTitle,
      usageCount: usageCount,
      totalDiscountAmount: totalDiscountAmount,
      revenueGenerated: revenueGenerated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'discountId': discountId,
      'discountTitle': discountTitle,
      'usageCount': usageCount,
      'totalDiscountAmount': totalDiscountAmount,
      'revenueGenerated': revenueGenerated,
    };
  }

  factory DiscountUsageModel.fromJson(Map<String, dynamic> json) {
    return DiscountUsageModel(
      discountId: json['discountId'],
      discountTitle: json['discountTitle'],
      usageCount: json['usageCount'],
      totalDiscountAmount: json['totalDiscountAmount'].toDouble(),
      revenueGenerated: json['revenueGenerated'].toDouble(),
    );
  }

  // Getter for compatibility with entity fields
  String get discountName => discountTitle;
}

class HourlySalesModel {
  final int hour;
  final int orderCount;
  final double revenue;

  HourlySalesModel({
    required this.hour,
    required this.orderCount,
    required this.revenue,
  });

  factory HourlySalesModel.fromEntity(HourlySalesEntity entity) {
    return HourlySalesModel(
      hour: entity.hour,
      orderCount: entity.orderCount,
      revenue: entity.revenue,
    );
  }

  HourlySalesEntity toEntity() {
    return HourlySalesEntity(
      hour: hour,
      orderCount: orderCount,
      revenue: revenue,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'orderCount': orderCount,
      'revenue': revenue,
    };
  }

  factory HourlySalesModel.fromJson(Map<String, dynamic> json) {
    return HourlySalesModel(
      hour: json['hour'],
      orderCount: json['orderCount'],
      revenue: json['revenue'].toDouble(),
    );
  }
}
