import 'package:equatable/equatable.dart';

class AnalyticsEntity extends Equatable {
  final String period; // 'daily', 'weekly', 'monthly', 'yearly'
  final String startDate;
  final String endDate;
  final SystemOverview overview;
  final SalesAnalytics sales;
  final UserAnalytics users;
  final VendorAnalytics vendors;
  final WalletAnalytics wallet;
  final OrderAnalytics orders;
  final List<PeakHourData> peakHours;
  final List<DailyTrend> dailyTrends;
  final List<CategoryPerformance> categoryPerformance;
  final List<PaymentMethodAnalytics> paymentMethods;

  const AnalyticsEntity({
    required this.period,
    required this.startDate,
    required this.endDate,
    required this.overview,
    required this.sales,
    required this.users,
    required this.vendors,
    required this.wallet,
    required this.orders,
    required this.peakHours,
    required this.dailyTrends,
    required this.categoryPerformance,
    required this.paymentMethods,
  });

  @override
  List<Object?> get props {
    return [
      period,
      startDate,
      endDate,
      overview,
      sales,
      users,
      vendors,
      wallet,
      orders,
      peakHours,
      dailyTrends,
      categoryPerformance,
      paymentMethods,
    ];
  }
}

class SystemOverview extends Equatable {
  final int totalUsers;
  final int totalVendors;
  final int totalOrders;
  final double totalRevenue;
  final int activeVendors;
  final int pendingVendors;
  final int totalComplaints;
  final int resolvedComplaints;
  final double averageOrderValue;
  final double systemUptime;

  const SystemOverview({
    required this.totalUsers,
    required this.totalVendors,
    required this.totalOrders,
    required this.totalRevenue,
    required this.activeVendors,
    required this.pendingVendors,
    required this.totalComplaints,
    required this.resolvedComplaints,
    required this.averageOrderValue,
    required this.systemUptime,
  });

  @override
  List<Object?> get props {
    return [
      totalUsers,
      totalVendors,
      totalOrders,
      totalRevenue,
      activeVendors,
      pendingVendors,
      totalComplaints,
      resolvedComplaints,
      averageOrderValue,
      systemUptime,
    ];
  }
}

class SalesAnalytics extends Equatable {
  final double totalSales;
  final double netSales;
  final double refunds;
  final double commission;
  final double vendorPayouts;
  final double growthRate;
  final int orderCount;
  final Map<String, double> salesByCategory;
  final Map<String, double> salesByVendor;
  final List<DailySales> dailySales;

  const SalesAnalytics({
    required this.totalSales,
    required this.netSales,
    required this.refunds,
    required this.commission,
    required this.vendorPayouts,
    required this.growthRate,
    required this.orderCount,
    required this.salesByCategory,
    required this.salesByVendor,
    required this.dailySales,
  });

  @override
  List<Object?> get props {
    return [
      totalSales,
      netSales,
      refunds,
      commission,
      vendorPayouts,
      growthRate,
      orderCount,
      salesByCategory,
      salesByVendor,
      dailySales,
    ];
  }
}

class UserAnalytics extends Equatable {
  final int totalStudents;
  final int activeStudents;
  final int newStudents;
  final int totalVendors;
  final int activeVendors;
  final int newVendors;
  final int totalAdmins;
  final double userGrowthRate;
  final double userRetentionRate;
  final double averageSessionDuration;
  final Map<String, int> usersByRole;

  const UserAnalytics({
    required this.totalStudents,
    required this.activeStudents,
    required this.newStudents,
    required this.totalVendors,
    required this.activeVendors,
    required this.newVendors,
    required this.totalAdmins,
    required this.userGrowthRate,
    required this.userRetentionRate,
    required this.averageSessionDuration,
    required this.usersByRole,
  });

  @override
  List<Object?> get props {
    return [
      totalStudents,
      activeStudents,
      newStudents,
      totalVendors,
      activeVendors,
      newVendors,
      totalAdmins,
      userGrowthRate,
      userRetentionRate,
      averageSessionDuration,
      usersByRole,
    ];
  }
}

class VendorAnalytics extends Equatable {
  final int totalVendors;
  final int activeVendors;
  final int pendingVendors;
  final int suspendedVendors;
  final double averageRating;
  final int totalReviews;
  final Map<String, int> vendorsByStatus;
  final Map<String, double> revenueByVendor;
  final Map<String, int> ordersByVendor;
  final List<TopVendor> topVendors;

  const VendorAnalytics({
    required this.totalVendors,
    required this.activeVendors,
    required this.pendingVendors,
    required this.suspendedVendors,
    required this.averageRating,
    required this.totalReviews,
    required this.vendorsByStatus,
    required this.revenueByVendor,
    required this.ordersByVendor,
    required this.topVendors,
  });

  @override
  List<Object?> get props {
    return [
      totalVendors,
      activeVendors,
      pendingVendors,
      suspendedVendors,
      averageRating,
      totalReviews,
      vendorsByStatus,
      revenueByVendor,
      ordersByVendor,
      topVendors,
    ];
  }
}

class WalletAnalytics extends Equatable {
  final double totalWalletBalance;
  final double totalTopups;
  final double totalSpent;
  final int totalTopupTransactions;
  final int totalWalletTransactions;
  final double averageTopupAmount;
  final double averageWalletBalance;
  final Map<String, double> topupsByPaymentMethod;
  final List<WalletTransaction> recentTransactions;

  const WalletAnalytics({
    required this.totalWalletBalance,
    required this.totalTopups,
    required this.totalSpent,
    required this.totalTopupTransactions,
    required this.totalWalletTransactions,
    required this.averageTopupAmount,
    required this.averageWalletBalance,
    required this.topupsByPaymentMethod,
    required this.recentTransactions,
  });

  @override
  List<Object?> get props {
    return [
      totalWalletBalance,
      totalTopups,
      totalSpent,
      totalTopupTransactions,
      totalWalletTransactions,
      averageTopupAmount,
      averageWalletBalance,
      topupsByPaymentMethod,
      recentTransactions,
    ];
  }
}

class OrderAnalytics extends Equatable {
  final int totalOrders;
  final int completedOrders;
  final int cancelledOrders;
  final int pendingOrders;
  final double averageOrderValue;
  final double averagePreparationTime;
  final double averageDeliveryTime;
  final Map<String, int> ordersByStatus;
  final Map<String, int> ordersByHour;
  final Map<String, int> ordersByDay;

  const OrderAnalytics({
    required this.totalOrders,
    required this.completedOrders,
    required this.cancelledOrders,
    required this.pendingOrders,
    required this.averageOrderValue,
    required this.averagePreparationTime,
    required this.averageDeliveryTime,
    required this.ordersByStatus,
    required this.ordersByHour,
    required this.ordersByDay,
  });

  @override
  List<Object?> get props {
    return [
      totalOrders,
      completedOrders,
      cancelledOrders,
      pendingOrders,
      averageOrderValue,
      averagePreparationTime,
      averageDeliveryTime,
      ordersByStatus,
      ordersByHour,
      ordersByDay,
    ];
  }
}

class PeakHourData extends Equatable {
  final String hour;
  final int orderCount;
  final double revenue;
  final double averageOrderValue;

  const PeakHourData({
    required this.hour,
    required this.orderCount,
    required this.revenue,
    required this.averageOrderValue,
  });

  @override
  List<Object?> get props {
    return [hour, orderCount, revenue, averageOrderValue];
  }
}

class DailyTrend extends Equatable {
  final String date;
  final int orders;
  final double revenue;
  final int newUsers;
  final int activeVendors;

  const DailyTrend({
    required this.date,
    required this.orders,
    required this.revenue,
    required this.newUsers,
    required this.activeVendors,
  });

  @override
  List<Object?> get props {
    return [date, orders, revenue, newUsers, activeVendors];
  }
}

class CategoryPerformance extends Equatable {
  final String category;
  final int orders;
  final double revenue;
  final double growthRate;
  final double marketShare;

  const CategoryPerformance({
    required this.category,
    required this.orders,
    required this.revenue,
    required this.growthRate,
    required this.marketShare,
  });

  @override
  List<Object?> get props {
    return [category, orders, revenue, growthRate, marketShare];
  }
}

class PaymentMethodAnalytics extends Equatable {
  final String method;
  final int transactionCount;
  final double totalAmount;
  final double percentage;

  const PaymentMethodAnalytics({
    required this.method,
    required this.transactionCount,
    required this.totalAmount,
    required this.percentage,
  });

  @override
  List<Object?> get props {
    return [method, transactionCount, totalAmount, percentage];
  }
}

class DailySales extends Equatable {
  final String date;
  final double sales;
  final int orders;
  final double averageOrderValue;

  const DailySales({
    required this.date,
    required this.sales,
    required this.orders,
    required this.averageOrderValue,
  });

  @override
  List<Object?> get props {
    return [date, sales, orders, averageOrderValue];
  }
}

class TopVendor extends Equatable {
  final String vendorId;
  final String vendorName;
  final int orders;
  final double revenue;
  final double rating;

  const TopVendor({
    required this.vendorId,
    required this.vendorName,
    required this.orders,
    required this.revenue,
    required this.rating,
  });

  @override
  List<Object?> get props {
    return [vendorId, vendorName, orders, revenue, rating];
  }
}

class WalletTransaction extends Equatable {
  final String transactionId;
  final String userId;
  final String userName;
  final String type; // 'topup', 'spend', 'refund'
  final double amount;
  final String paymentMethod;
  final String timestamp;
  final String status;

  const WalletTransaction({
    required this.transactionId,
    required this.userId,
    required this.userName,
    required this.type,
    required this.amount,
    required this.paymentMethod,
    required this.timestamp,
    required this.status,
  });

  @override
  List<Object?> get props {
    return [
      transactionId,
      userId,
      userName,
      type,
      amount,
      paymentMethod,
      timestamp,
      status,
    ];
  }
}
