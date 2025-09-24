import 'package:campus_food_app/data/models/user_model.dart';
import 'package:campus_food_app/data/models/vendor_model.dart';
import 'package:campus_food_app/data/models/menu_item_model.dart';
import 'package:campus_food_app/data/models/discount_model.dart';
import 'package:campus_food_app/data/models/order_model.dart';
import 'package:campus_food_app/data/models/transaction_model.dart';
import 'package:campus_food_app/data/models/enhanced_discount_model.dart';
import 'package:campus_food_app/data/models/pickup_slot_model.dart';
import 'package:campus_food_app/data/models/sales_report_model.dart';
import 'package:campus_food_app/core/utils/app_constants.dart';
import 'package:campus_food_app/domain/entities/enhanced_discount_entity.dart';

class MockDataSource {
  // Mock Users
  static final List<UserModel> users = [
    const UserModel(
      userId: 'user_1',
      email: 'student@campus.edu',
      campusId: 'STU001',
      role: AppConstants.roleStudent,
      name: 'Jash',
      walletBalance: 4150.00,
      phoneNumber: '+1234567890',
    ),
    const UserModel(
      userId: 'user_2',
      email: 'vendor1@campus.edu',
      campusId: 'VEN001',
      role: AppConstants.roleVendor,
      name: 'Foodies Owner',
      walletBalance: 83000.00,
      phoneNumber: '+1234567891',
    ),
    const UserModel(
      userId: 'user_3',
      email: 'admin@campus.edu',
      campusId: 'ADM001',
      role: AppConstants.roleAdmin,
      name: 'Admin',
      walletBalance: 0.00,
      phoneNumber: '+1234567892',
    ),
    const UserModel(
      userId: 'user_4',
      email: 'student2@campus.edu',
      campusId: 'STU002',
      role: AppConstants.roleStudent,
      name: 'Divy',
      walletBalance: 6266.50,
      phoneNumber: '+1234567893',
    ),
  ];

  // Mock Vendors
  static final List<VendorModel> vendors = [
    const VendorModel(
      vendorId: 'vendor_1',
      name: 'Foodies',
      description: 'Fresh pizzas made with love',
      imageUrl: 'assets/images/pizza_palace.jpg',
      status: AppConstants.vendorOpen,
      rating: 4.5,
      reviewCount: 120,
      location: 'Main Campus - Building A',
      phoneNumber: '+1234567890',
      ownerId: 'user_2',
    ),
    const VendorModel(
      vendorId: 'vendor_2',
      name: 'Gurukrupa Snacks',
      description: 'Juicy burgers and fries',
      imageUrl: 'assets/images/burger_barn.jpg',
      status: AppConstants.vendorOpen,
      rating: 4.2,
      reviewCount: 85,
      location: 'Main Campus - Building B',
      phoneNumber: '+1234567891',
      ownerId: 'user_5',
    ),
    const VendorModel(
      vendorId: 'vendor_3',
      name: 'Soda Shop',
      description: 'Fresh Japanese cuisine',
      imageUrl: 'assets/images/sushi_station.jpg',
      status: AppConstants.vendorPendingApproval,
      rating: 0.0,
      reviewCount: 0,
      location: 'Main Campus - Building C',
      phoneNumber: '+1234567892',
      ownerId: 'user_6',
    ),
    const VendorModel(
      vendorId: 'vendor_4',
      name: 'Ballu Canteen',
      description: 'Authentic Indian snacks',
      imageUrl: 'assets/images/taco_time.jpg',
      status: AppConstants.vendorClosed,
      rating: 4.0,
      reviewCount: 45,
      location: 'Main Campus - Building D',
      phoneNumber: '+1234567893',
      ownerId: 'user_7',
    ),
  ];

  // Mock Menu Items
  static final List<MenuItemModel> menuItems = [
    const MenuItemModel(
      menuItemId: 'menu_1',
      vendorId: 'vendor_1',
      name: 'Margherita Pizza',
      description: 'Classic pizza with tomato sauce and mozzarella',
      price: 250.00,
      imageUrl: 'assets/images/margherita_pizza.jpg',
      isAvailable: true,
      category: 'Pizza',
      preparationTime: 15,
      tags: ['vegetarian', 'classic'],
    ),
    const MenuItemModel(
      menuItemId: 'menu_2',
      vendorId: 'vendor_1',
      name: 'Veggie Pizza',
      description: 'Pizza with a variety of fresh vegetables',
      price: 300.00,
      imageUrl: 'assets/images/veggie_pizza.jpg',
      isAvailable: true,
      category: 'Pizza',
      preparationTime: 15,
      tags: ['vegetarian', 'healthy'],
    ),
    const MenuItemModel(
      menuItemId: 'menu_3',
      vendorId: 'vendor_2',
      name: 'Veggie Burger',
      description: 'A delicious vegetable patty burger',
      price: 120.00,
      imageUrl: 'assets/images/veggie_burger.jpg',
      isAvailable: true,
      category: 'Burgers',
      preparationTime: 10,
      tags: ['vegetarian', 'popular'],
    ),
    const MenuItemModel(
      menuItemId: 'menu_4',
      vendorId: 'vendor_2',
      name: 'Paneer Burger',
      description: 'A burger with a crispy paneer patty',
      price: 150.00,
      imageUrl: 'assets/images/paneer_burger.jpg',
      isAvailable: true,
      category: 'Burgers',
      preparationTime: 12,
      tags: ['vegetarian', 'paneer'],
    ),
    const MenuItemModel(
      menuItemId: 'menu_5',
      vendorId: 'vendor_3',
      name: 'Veg Sushi Roll',
      description: 'Avocado, cucumber, and carrot sushi roll',
      price: 200.00,
      imageUrl: 'assets/images/veg_sushi.jpg',
      isAvailable: true,
      category: 'Sushi',
      preparationTime: 20,
      tags: ['vegetarian', 'sushi'],
    ),
    const MenuItemModel(
      menuItemId: 'menu_6',
      vendorId: 'vendor_4',
      name: 'Paneer Taco',
      description: 'A taco with spicy paneer and fresh toppings',
      price: 100.00,
      imageUrl: 'assets/images/paneer_taco.jpg',
      isAvailable: true,
      category: 'Tacos',
      preparationTime: 8,
      tags: ['vegetarian', 'paneer'],
    ),
  ];

  // Mock Discounts
  static final List<DiscountModel> discounts = [
    const DiscountModel(
      discountId: 'discount_1',
      vendorId: 'vendor_1',
      type: AppConstants.discountPercentage,
      value: 10.0,
      description: '10% off on all pizzas',
      minOrderAmount: 400.0,
      isActive: true,
    ),
    const DiscountModel(
      discountId: 'discount_2',
      vendorId: 'vendor_2',
      type: AppConstants.discountFixed,
      value: 50.0,
      description: '₹50 off on burgers',
      minOrderAmount: 200.0,
      isActive: true,
    ),
  ];

  // Mock Orders
  static final List<OrderModel> orders = [
    OrderModel(
      orderId: 'order_1',
      studentId: 'user_1',
      vendorId: 'vendor_1',
      items: [
        OrderItemModel(
          menuItemId: 'menu_1',
          name: 'Margherita Pizza',
          price: 250.00,
          quantity: 1,
        ),
      ],
      totalAmount: 250.00,
      status: AppConstants.orderCompleted,
      pickupSlot: DateTime.now().subtract(const Duration(hours: 2)),
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    OrderModel(
      orderId: 'order_2',
      studentId: 'user_4',
      vendorId: 'vendor_2',
      items: [
        OrderItemModel(
          menuItemId: 'menu_3',
          name: 'Veggie Burger',
          price: 120.00,
          quantity: 2,
        ),
      ],
      totalAmount: 240.00,
      status: AppConstants.orderPreparing,
      pickupSlot: DateTime.now().add(const Duration(minutes: 30)),
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      updatedAt: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
  ];

  // Mock Transactions
  static final List<TransactionModel> transactions = [
    TransactionModel(
      transactionId: 'txn_1',
      userId: 'user_1',
      amount: 500.00,
      type: AppConstants.transactionCredit,
      status: AppConstants.transactionSuccess,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      description: 'Wallet top-up',
    ),
    TransactionModel(
      transactionId: 'txn_2',
      userId: 'user_1',
      amount: 250.00,
      type: AppConstants.transactionDebit,
      status: AppConstants.transactionSuccess,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      description: 'Order payment',
      orderId: 'order_1',
    ),
    TransactionModel(
      transactionId: 'txn_3',
      userId: 'user_4',
      amount: 1000.00,
      type: AppConstants.transactionCredit,
      status: AppConstants.transactionSuccess,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      description: 'Wallet top-up',
    ),
  ];

  // Mock Enhanced Discounts
  static final List<EnhancedDiscountModel> enhancedDiscounts = [
    EnhancedDiscountModel(
      discountId: 'discount_1',
      vendorId: 'vendor_1',
      title: 'Happy Hour Special',
      description: '20% off during happy hours',
      type: 'happy_hour',
      value: 20.0,
      minOrderAmount: 200.0,
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now().add(const Duration(days: 30)),
      happyHourDays: [1, 2, 3, 4, 5], // Monday to Friday
      happyHourStartTime: const TimeOfDay(hour: 14, minute: 0),
      happyHourEndTime: const TimeOfDay(hour: 17, minute: 0),
      happyHourDiscountRate: 20.0,
      maxUsageCount: 100,
      currentUsageCount: 45,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    EnhancedDiscountModel(
      discountId: 'discount_2',
      vendorId: 'vendor_1',
      title: 'Combo Deal',
      description: 'Pizza + Drink combo',
      type: 'combo',
      value: 50.0,
      minOrderAmount: 300.0,
      requiredMenuItemIds: ['menu_1', 'menu_5'],
      comboPrice: 350.0,
      comboName: 'Pizza + Drink Combo',
      maxUsageCount: 50,
      currentUsageCount: 20,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  // Mock Pickup Slots
  static final List<PickupSlotModel> pickupSlots = [
    PickupSlotModel(
      slotId: 'slot_1',
      vendorId: 'vendor_1',
      startTime: DateTime(2024, 1, 1, 11, 0),
      endTime: DateTime(2024, 1, 1, 11, 30),
      maxCapacity: 10,
      currentBookings: 3,
      preparationTime: 15,
      isActive: true,
    ),
    PickupSlotModel(
      slotId: 'slot_2',
      vendorId: 'vendor_1',
      startTime: DateTime(2024, 1, 1, 12, 0),
      endTime: DateTime(2024, 1, 1, 12, 30),
      maxCapacity: 10,
      currentBookings: 7,
      preparationTime: 15,
      isActive: true,
    ),
    PickupSlotModel(
      slotId: 'slot_3',
      vendorId: 'vendor_2',
      startTime: DateTime(2024, 1, 1, 13, 0),
      endTime: DateTime(2024, 1, 1, 13, 30),
      maxCapacity: 8,
      currentBookings: 2,
      preparationTime: 10,
      isActive: true,
    ),
  ];

  // Mock Sales Reports
  static final List<SalesReportModel> salesReports = [
    SalesReportModel(
      reportId: 'report_1',
      vendorId: 'vendor_1',
      reportDate: DateTime.now().subtract(const Duration(days: 1)),
      totalRevenue: 15000.0,
      totalOrders: 45,
      averageOrderValue: 333.33,
      topSellingItems: [
        SalesItemModel(
          itemId: 'menu_1',
          itemName: 'Margherita Pizza',
          quantitySold: 15,
          totalRevenue: 3750.0,
          orderCount: 15,
        ),
        SalesItemModel(
          itemId: 'menu_2',
          itemName: 'Veggie Pizza',
          quantitySold: 12,
          totalRevenue: 3600.0,
          orderCount: 12,
        ),
      ],
      discountUsage: [
        DiscountUsageModel(
          discountId: 'discount_1',
          discountTitle: 'Happy Hour Special',
          usageCount: 20,
          totalDiscountAmount: 2000.0,
          revenueGenerated: 10000.0,
        ),
      ],
      hourlySales: [
        HourlySalesModel(hour: 11, orderCount: 8, revenue: 2666.67),
        HourlySalesModel(hour: 12, orderCount: 15, revenue: 5000.0),
        HourlySalesModel(hour: 13, orderCount: 12, revenue: 4000.0),
      ],
    ),
    SalesReportModel(
      reportId: 'report_2',
      vendorId: 'vendor_2',
      reportDate: DateTime.now().subtract(const Duration(days: 1)),
      totalRevenue: 8500.0,
      totalOrders: 30,
      averageOrderValue: 283.33,
      topSellingItems: [
        SalesItemModel(
          itemId: 'menu_3',
          itemName: 'Veggie Burger',
          quantitySold: 18,
          totalRevenue: 2160.0,
          orderCount: 18,
        ),
        SalesItemModel(
          itemId: 'menu_4',
          itemName: 'Paneer Burger',
          quantitySold: 12,
          totalRevenue: 1800.0,
          orderCount: 12,
        ),
      ],
      discountUsage: [],
      hourlySales: [
        HourlySalesModel(hour: 12, orderCount: 10, revenue: 2833.33),
        HourlySalesModel(hour: 13, orderCount: 12, revenue: 3400.0),
        HourlySalesModel(hour: 14, orderCount: 8, revenue: 2266.67),
      ],
    ),
  ];

  // Helper methods to get data
  static UserModel? getUserByEmail(String email) {
    try {
      return users.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  static UserModel? getUserById(String userId) {
    try {
      return users.firstWhere((user) => user.userId == userId);
    } catch (e) {
      return null;
    }
  }

  static List<VendorModel> getVendorsByStatus(String status) {
    return vendors.where((vendor) => vendor.status == status).toList();
  }

  static List<MenuItemModel> getMenuItemsByVendor(String vendorId) {
    return menuItems.where((item) => item.vendorId == vendorId).toList();
  }

  static List<OrderModel> getOrdersByUser(String userId) {
    return orders.where((order) => order.studentId == userId).toList();
  }

  static List<OrderModel> getOrdersByVendor(String vendorId) {
    return orders.where((order) => order.vendorId == vendorId).toList();
  }

  static List<TransactionModel> getTransactionsByUser(String userId) {
    return transactions.where((transaction) => transaction.userId == userId).toList();
  }

  // Enhanced Discount methods
  static List<EnhancedDiscountModel> getEnhancedDiscountsByVendor(String vendorId) {
    return enhancedDiscounts.where((discount) => discount.vendorId == vendorId).toList();
  }

  static EnhancedDiscountModel? getEnhancedDiscountById(String discountId) {
    try {
      return enhancedDiscounts.firstWhere((discount) => discount.discountId == discountId);
    } catch (e) {
      return null;
    }
  }

  // Pickup Slot methods
  static List<PickupSlotModel> getPickupSlotsByVendor(String vendorId) {
    return pickupSlots.where((slot) => slot.vendorId == vendorId).toList();
  }

  static PickupSlotModel? getPickupSlotById(String slotId) {
    try {
      return pickupSlots.firstWhere((slot) => slot.slotId == slotId);
    } catch (e) {
      return null;
    }
  }

  // Sales Report methods
  static List<SalesReportModel> getSalesReportsByVendor(String vendorId) {
    return salesReports.where((report) => report.vendorId == vendorId).toList();
  }

  static SalesReportModel? getSalesReportById(String reportId) {
    try {
      return salesReports.firstWhere((report) => report.reportId == reportId);
    } catch (e) {
      return null;
    }
  }

  // Additional sales report methods
  static SalesReportModel getDailySalesReport(String vendorId, DateTime date) {
    final vendorReports = getSalesReportsByVendor(vendorId);
    final report = vendorReports.firstWhere(
      (r) => r.reportDate.year == date.year && 
             r.reportDate.month == date.month && 
             r.reportDate.day == date.day,
      orElse: () => _generateDailyReport(vendorId, date),
    );
    return report;
  }

  static SalesReportModel getWeeklySalesReport(String vendorId, DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 6));
    final vendorReports = getSalesReportsByVendor(vendorId);
    final weekReports = vendorReports.where(
      (r) => r.reportDate.isAfter(weekStart.subtract(const Duration(days: 1))) && 
             r.reportDate.isBefore(weekEnd.add(const Duration(days: 1))),
    ).toList();
    
    if (weekReports.isEmpty) {
      return _generateWeeklyReport(vendorId, weekStart);
    }
    
    return _aggregateReports(weekReports, 'weekly_${vendorId}_${weekStart.millisecondsSinceEpoch}');
  }

  static SalesReportModel getMonthlySalesReport(String vendorId, DateTime month) {
    final vendorReports = getSalesReportsByVendor(vendorId);
    final monthReports = vendorReports.where(
      (r) => r.reportDate.year == month.year && r.reportDate.month == month.month,
    ).toList();
    
    if (monthReports.isEmpty) {
      return _generateMonthlyReport(vendorId, month);
    }
    
    return _aggregateReports(monthReports, 'monthly_${vendorId}_${month.year}_${month.month}');
  }

  static List<SalesReportModel> getSalesReportsByDateRange(
    String vendorId,
    DateTime startDate,
    DateTime endDate,
  ) {
    final vendorReports = getSalesReportsByVendor(vendorId);
    return vendorReports.where(
      (r) => r.reportDate.isAfter(startDate.subtract(const Duration(days: 1))) && 
             r.reportDate.isBefore(endDate.add(const Duration(days: 1))),
    ).toList();
  }

  static List<SalesItemModel> getTopSellingItems(
    String vendorId,
    DateTime startDate,
    DateTime endDate,
    int limit,
  ) {
    final reports = getSalesReportsByDateRange(vendorId, startDate, endDate);
    final allItems = <String, SalesItemModel>{};
    
    for (final report in reports) {
      for (final item in report.topSellingItems) {
        if (allItems.containsKey(item.itemId)) {
          final existing = allItems[item.itemId]!;
          allItems[item.itemId] = SalesItemModel(
            itemId: item.itemId,
            itemName: item.itemName,
            quantitySold: existing.quantitySold + item.quantitySold,
            totalRevenue: existing.totalRevenue + item.totalRevenue,
            orderCount: existing.orderCount + item.orderCount,
          );
        } else {
          allItems[item.itemId] = item;
        }
      }
    }
    
    final sortedItems = allItems.values.toList()
      ..sort((a, b) => b.totalRevenue.compareTo(a.totalRevenue));
    
    return sortedItems.take(limit).toList();
  }

  static List<DiscountUsageModel> getDiscountUsage(
    String vendorId,
    DateTime startDate,
    DateTime endDate,
  ) {
    final reports = getSalesReportsByDateRange(vendorId, startDate, endDate);
    final allUsage = <String, DiscountUsageModel>{};
    
    for (final report in reports) {
      for (final usage in report.discountUsage) {
        if (allUsage.containsKey(usage.discountId)) {
          final existing = allUsage[usage.discountId]!;
          allUsage[usage.discountId] = DiscountUsageModel(
            discountId: usage.discountId,
            discountTitle: usage.discountTitle,
            usageCount: existing.usageCount + usage.usageCount,
            totalDiscountAmount: existing.totalDiscountAmount + usage.totalDiscountAmount,
            revenueGenerated: existing.revenueGenerated + usage.revenueGenerated,
          );
        } else {
          allUsage[usage.discountId] = usage;
        }
      }
    }
    
    return allUsage.values.toList();
  }

  static List<HourlySalesModel> getHourlySales(String vendorId, DateTime date) {
    final report = getDailySalesReport(vendorId, date);
    return report.hourlySales;
  }

  static Map<String, dynamic> getSalesSummary(String vendorId) {
    final vendorReports = getSalesReportsByVendor(vendorId);
    if (vendorReports.isEmpty) {
      return {
        'totalRevenue': 0.0,
        'totalOrders': 0,
        'averageOrderValue': 0.0,
        'bestSellingItem': 'No data',
        'peakHour': 12,
        'mostUsedDiscount': 'No data',
        'revenueGrowth': 0.0,
      };
    }
    
    final totalRevenue = vendorReports.fold(0.0, (sum, report) => sum + report.totalRevenue);
    final totalOrders = vendorReports.fold(0, (sum, report) => sum + report.totalOrders);
    final averageOrderValue = totalOrders > 0 ? totalRevenue / totalOrders : 0.0;
    
    // Find best selling item
    final allItems = <String, int>{};
    for (final report in vendorReports) {
      for (final item in report.topSellingItems) {
        allItems[item.itemName] = (allItems[item.itemName] ?? 0) + item.quantitySold;
      }
    }
    final bestSellingItem = allItems.entries.fold('', (best, entry) => 
      entry.value > (allItems[best] ?? 0) ? entry.key : best);
    
    // Find peak hour
    final hourlyData = <int, int>{};
    for (final report in vendorReports) {
      for (final hourly in report.hourlySales) {
        hourlyData[hourly.hour] = (hourlyData[hourly.hour] ?? 0) + hourly.orderCount;
      }
    }
    final peakHour = hourlyData.entries.fold(12, (peak, entry) => 
      entry.value > (hourlyData[peak] ?? 0) ? entry.key : peak);
    
    return {
      'totalRevenue': totalRevenue,
      'totalOrders': totalOrders,
      'averageOrderValue': averageOrderValue,
      'bestSellingItem': bestSellingItem.isNotEmpty ? bestSellingItem : 'No data',
      'peakHour': peakHour,
      'mostUsedDiscount': 'Happy Hour Special', // Mock data
      'revenueGrowth': 15.5, // Mock data
    };
  }

  // Helper methods for generating mock reports
  static SalesReportModel _generateDailyReport(String vendorId, DateTime date) {
    return SalesReportModel(
      reportId: 'daily_${vendorId}_${date.millisecondsSinceEpoch}',
      vendorId: vendorId,
      reportDate: date,
      totalRevenue: 2500.0 + (date.day * 100),
      totalOrders: 20 + (date.day % 10),
      averageOrderValue: 125.0,
      topSellingItems: [
        SalesItemModel(
          itemId: 'menu_1',
          itemName: 'Margherita Pizza',
          quantitySold: 15,
          totalRevenue: 3750.0,
          orderCount: 15,
        ),
        SalesItemModel(
          itemId: 'menu_2',
          itemName: 'Veggie Burger',
          quantitySold: 12,
          totalRevenue: 1440.0,
          orderCount: 12,
        ),
      ],
      discountUsage: [
        DiscountUsageModel(
          discountId: 'discount_1',
          discountTitle: 'Happy Hour Special',
          usageCount: 8,
          totalDiscountAmount: 400.0,
          revenueGenerated: 2000.0,
        ),
      ],
      hourlySales: List.generate(24, (hour) => 
        HourlySalesModel(
          hour: hour,
          orderCount: hour >= 11 && hour <= 14 ? 3 : 1,
          revenue: hour >= 11 && hour <= 14 ? 375.0 : 125.0,
        ),
      ),
    );
  }

  static SalesReportModel _generateWeeklyReport(String vendorId, DateTime weekStart) {
    final reports = List.generate(7, (day) => 
      _generateDailyReport(vendorId, weekStart.add(Duration(days: day))),
    );
    return _aggregateReports(reports, 'weekly_${vendorId}_${weekStart.millisecondsSinceEpoch}');
  }

  static SalesReportModel _generateMonthlyReport(String vendorId, DateTime month) {
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final reports = List.generate(daysInMonth, (day) => 
      _generateDailyReport(vendorId, DateTime(month.year, month.month, day + 1)),
    );
    return _aggregateReports(reports, 'monthly_${vendorId}_${month.year}_${month.month}');
  }

  static SalesReportModel _aggregateReports(
    List<SalesReportModel> reports,
    String reportId,
  ) {
    if (reports.isEmpty) {
      return SalesReportModel(
        reportId: reportId,
        vendorId: 'unknown',
        reportDate: DateTime.now(),
        totalRevenue: 0.0,
        totalOrders: 0,
        averageOrderValue: 0.0,
        topSellingItems: [],
        discountUsage: [],
        hourlySales: [],
      );
    }
    
    final totalRevenue = reports.fold(0.0, (sum, report) => sum + report.totalRevenue);
    final totalOrders = reports.fold(0, (sum, report) => sum + report.totalOrders);
    final averageOrderValue = totalOrders > 0 ? totalRevenue / totalOrders : 0.0;
    
    // Aggregate top selling items
    final allItems = <String, SalesItemModel>{};
    for (final report in reports) {
      for (final item in report.topSellingItems) {
        if (allItems.containsKey(item.itemId)) {
          final existing = allItems[item.itemId]!;
          allItems[item.itemId] = SalesItemModel(
            itemId: item.itemId,
            itemName: item.itemName,
            quantitySold: existing.quantitySold + item.quantitySold,
            totalRevenue: existing.totalRevenue + item.totalRevenue,
            orderCount: existing.orderCount + item.orderCount,
          );
        } else {
          allItems[item.itemId] = item;
        }
      }
    }
    
    // Aggregate discount usage
    final allUsage = <String, DiscountUsageModel>{};
    for (final report in reports) {
      for (final usage in report.discountUsage) {
        if (allUsage.containsKey(usage.discountId)) {
          final existing = allUsage[usage.discountId]!;
          allUsage[usage.discountId] = DiscountUsageModel(
            discountId: usage.discountId,
            discountTitle: usage.discountTitle,
            usageCount: existing.usageCount + usage.usageCount,
            totalDiscountAmount: existing.totalDiscountAmount + usage.totalDiscountAmount,
            revenueGenerated: existing.revenueGenerated + usage.revenueGenerated,
          );
        } else {
          allUsage[usage.discountId] = usage;
        }
      }
    }
    
    // Aggregate hourly sales
    final hourlyData = <int, HourlySalesModel>{};
    for (final report in reports) {
      for (final hourly in report.hourlySales) {
        if (hourlyData.containsKey(hourly.hour)) {
          final existing = hourlyData[hourly.hour]!;
          hourlyData[hourly.hour] = HourlySalesModel(
            hour: hourly.hour,
            orderCount: existing.orderCount + hourly.orderCount,
            revenue: existing.revenue + hourly.revenue,
          );
        } else {
          hourlyData[hourly.hour] = hourly;
        }
      }
    }
    
    return SalesReportModel(
      reportId: reportId,
      vendorId: reports.first.vendorId,
      reportDate: reports.first.reportDate,
      totalRevenue: totalRevenue,
      totalOrders: totalOrders,
      averageOrderValue: averageOrderValue,
      topSellingItems: allItems.values.toList()
        ..sort((a, b) => b.totalRevenue.compareTo(a.totalRevenue)),
      discountUsage: allUsage.values.toList(),
      hourlySales: hourlyData.values.toList()..sort((a, b) => a.hour.compareTo(b.hour)),
    );
  }
}