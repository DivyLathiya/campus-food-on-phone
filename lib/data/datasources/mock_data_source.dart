import 'package:campus_food_app/data/models/user_model.dart';
import 'package:campus_food_app/data/models/vendor_model.dart';
import 'package:campus_food_app/data/models/enhanced_vendor_model.dart';
import 'package:campus_food_app/data/models/menu_item_model.dart';
import 'package:campus_food_app/data/models/discount_model.dart';
import 'package:campus_food_app/data/models/order_model.dart';
import 'package:campus_food_app/data/models/transaction_model.dart';
import 'package:campus_food_app/data/models/enhanced_discount_model.dart';
import 'package:campus_food_app/data/models/pickup_slot_model.dart';
import 'package:campus_food_app/data/models/sales_report_model.dart';
import 'package:campus_food_app/data/models/complaint_model.dart';
import 'package:campus_food_app/core/utils/app_constants.dart';
import 'package:campus_food_app/domain/entities/enhanced_discount_entity.dart';
import 'package:campus_food_app/domain/entities/analytics_entity.dart';

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

  // Mock Enhanced Vendors Data
  static final List<EnhancedVendorModel> enhancedVendors = [
    EnhancedVendorModel(
      vendorId: 'vendor_1',
      name: 'Foodies',
      description: 'Best pizza and burgers on campus',
      imageUrl: 'assets/images/foodies.jpg',
      status: 'open',
      rating: 4.5,
      reviewCount: 120,
      location: 'Main Campus - Building A',
      phoneNumber: '+1234567890',
      ownerId: 'user_2',
      kycStatus: 'verified',
      kycSubmittedAt: '2024-01-01T10:00:00Z',
      kycVerifiedAt: '2024-01-02T15:30:00Z',
      businessLicense: 'BL001',
      taxId: 'TAX001',
      bankAccount: 'ACC001',
      bankName: 'Campus Bank',
      accountHolderName: 'Foodies Owner',
      identityDocument: 'ID001',
      addressProof: 'ADDR001',
      isComplianceChecked: true,
      complianceCheckedAt: '2024-01-03T10:00:00Z',
      complianceCheckedBy: 'user_3',
    ),
    EnhancedVendorModel(
      vendorId: 'vendor_2',
      name: 'Tasty Bites',
      description: 'Delicious snacks and beverages',
      imageUrl: 'assets/images/tasty_bites.jpg',
      status: 'pending_approval',
      rating: 4.2,
      reviewCount: 85,
      location: 'Main Campus - Building B',
      phoneNumber: '+1234567891',
      ownerId: 'user_5',
      kycStatus: 'pending',
      kycSubmittedAt: '2024-01-10T09:00:00Z',
      businessLicense: 'BL002',
      taxId: 'TAX002',
      bankAccount: 'ACC002',
      bankName: 'Campus Bank',
      accountHolderName: 'Tasty Bites Owner',
      identityDocument: 'ID002',
      addressProof: 'ADDR002',
    ),
    EnhancedVendorModel(
      vendorId: 'vendor_3',
      name: 'Healthy Eats',
      description: 'Fresh and healthy food options',
      imageUrl: 'assets/images/healthy_eats.jpg',
      status: 'rejected',
      rating: 4.0,
      reviewCount: 45,
      location: 'Main Campus - Building C',
      phoneNumber: '+1234567892',
      ownerId: 'user_6',
      kycStatus: 'rejected',
      kycSubmittedAt: '2024-01-05T11:00:00Z',
      kycRejectedAt: '2024-01-06T14:00:00Z',
      kycRejectedReason: 'Invalid business license',
      businessLicense: 'BL003',
      taxId: 'TAX003',
      bankAccount: 'ACC003',
      bankName: 'Campus Bank',
      accountHolderName: 'Healthy Eats Owner',
      identityDocument: 'ID003',
      addressProof: 'ADDR003',
    ),
    EnhancedVendorModel(
      vendorId: 'vendor_4',
      name: 'Quick Bites',
      description: 'Fast food and quick meals',
      imageUrl: 'assets/images/quick_bites.jpg',
      status: 'suspended',
      rating: 3.8,
      reviewCount: 60,
      location: 'Main Campus - Building D',
      phoneNumber: '+1234567893',
      ownerId: 'user_7',
      kycStatus: 'verified',
      kycSubmittedAt: '2024-01-01T12:00:00Z',
      kycVerifiedAt: '2024-01-02T16:00:00Z',
      businessLicense: 'BL004',
      taxId: 'TAX004',
      bankAccount: 'ACC004',
      bankName: 'Campus Bank',
      accountHolderName: 'Quick Bites Owner',
      identityDocument: 'ID004',
      addressProof: 'ADDR004',
      isComplianceChecked: true,
      complianceCheckedAt: '2024-01-03T11:00:00Z',
      complianceCheckedBy: 'user_3',
    ),
    EnhancedVendorModel(
      vendorId: 'vendor_5',
      name: 'Sweet Treats',
      description: 'Desserts and sweet snacks',
      imageUrl: 'assets/images/sweet_treats.jpg',
      status: 'open',
      rating: 4.7,
      reviewCount: 95,
      location: 'Main Campus - Building E',
      phoneNumber: '+1234567894',
      ownerId: 'user_8',
      kycStatus: 'pending',
      kycSubmittedAt: '2024-01-15T08:00:00Z',
      businessLicense: 'BL005',
      taxId: 'TAX005',
      bankAccount: 'ACC005',
      bankName: 'Campus Bank',
      accountHolderName: 'Sweet Treats Owner',
      identityDocument: 'ID005',
      addressProof: 'ADDR005',
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
      paymentMethod: 'wallet',
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
      paymentMethod: 'other',
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
    EnhancedDiscountModel(
      discountId: 'discount_3',
      vendorId: 'vendor_1',
      title: 'Wallet Wednesday',
      description: '15% off when paying with wallet',
      type: 'percentage',
      value: 15.0,
      minOrderAmount: 150.0,
      startDate: DateTime.now().subtract(const Duration(days: 7)),
      endDate: DateTime.now().add(const Duration(days: 30)),
      walletOnly: true,
      maxUsageCount: 200,
      currentUsageCount: 75,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    EnhancedDiscountModel(
      discountId: 'discount_4',
      vendorId: 'vendor_1',
      title: 'Wallet Cashback',
      description: '₹50 off on orders above ₹500 when paying with wallet',
      type: 'fixed',
      value: 50.0,
      minOrderAmount: 500.0,
      startDate: DateTime.now().subtract(const Duration(days: 3)),
      endDate: DateTime.now().add(const Duration(days: 14)),
      walletOnly: true,
      maxUsageCount: 100,
      currentUsageCount: 30,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
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

  // Analytics Methods
  static AnalyticsEntity getAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) {
    return AnalyticsEntity(
      period: period,
      startDate: startDate ?? DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      endDate: endDate ?? DateTime.now().toIso8601String(),
      overview: getSystemOverview(),
      sales: getSalesAnalytics(period: period, startDate: startDate, endDate: endDate),
      users: getUserAnalytics(period: period, startDate: startDate, endDate: endDate),
      vendors: getVendorAnalytics(period: period, startDate: startDate, endDate: endDate),
      wallet: getWalletAnalytics(period: period, startDate: startDate, endDate: endDate),
      orders: getOrderAnalytics(period: period, startDate: startDate, endDate: endDate),
      peakHours: getPeakHourAnalysis(period: period, startDate: startDate, endDate: endDate),
      dailyTrends: getDailyTrends(period: period, startDate: startDate, endDate: endDate),
      categoryPerformance: getCategoryPerformance(period: period, startDate: startDate, endDate: endDate),
      paymentMethods: getPaymentMethodAnalytics(period: period, startDate: startDate, endDate: endDate),
    );
  }

  static SystemOverview getSystemOverview({
    String? period,
    String? startDate,
    String? endDate,
  }) {
    return SystemOverview(
      totalUsers: users.where((u) => u.role == AppConstants.roleStudent).length,
      totalVendors: vendors.where((v) => v.status == 'approved').length,
      totalOrders: orders.length,
      totalRevenue: orders.where((o) => o.status == 'completed').fold(0.0, (sum, order) => sum + order.totalAmount),
      activeVendors: 8,
      pendingVendors: vendors.where((v) => v.status == 'pending').length,
      totalComplaints: 25,
      resolvedComplaints: 20,
      averageOrderValue: orders.isNotEmpty ? orders.fold(0.0, (sum, order) => sum + order.totalAmount) / orders.length : 0.0,
      systemUptime: 99.5,
    );
  }

  static SalesAnalytics getSalesAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) {
    final completedOrders = orders.where((o) => o.status == 'completed');
    final totalSalesAmount = completedOrders.fold(0.0, (sum, order) => sum + order.totalAmount);
    return SalesAnalytics(
      totalSales: totalSalesAmount,
      netSales: totalSalesAmount * 0.92,
      refunds: totalSalesAmount * 0.03,
      commission: totalSalesAmount * 0.05,
      vendorPayouts: totalSalesAmount * 0.87,
      growthRate: 0.15,
      orderCount: completedOrders.length,
      salesByCategory: {
        'Snacks': 33750.0,
        'Main Course': 57000.0,
        'Beverages': 15600.0,
      },
      salesByVendor: {
        'Foodies': 45000.0,
        'Cafe Corner': 32000.0,
        'Quick Bites': 29350.0,
      },
      dailySales: List.generate(7, (days) {
        final date = DateTime.now().subtract(Duration(days: days));
        return DailySales(
          date: date.toIso8601String(),
          sales: 18000.0 + (days % 10) * 750.0,
          orders: 120 + (days % 10) * 5,
          averageOrderValue: 150.0,
        );
      }),
    );
  }

  static UserAnalytics getUserAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) {
    final studentUsers = users.where((u) => u.role == AppConstants.roleStudent);
    final vendorUsers = users.where((u) => u.role == AppConstants.roleVendor);
    final adminUsers = users.where((u) => u.role == AppConstants.roleAdmin);
    return UserAnalytics(
      totalStudents: studentUsers.length,
      activeStudents: studentUsers.where((u) => u.walletBalance > 0).length,
      newStudents: 5,
      totalVendors: vendorUsers.length,
      activeVendors: vendorUsers.where((v) => v.walletBalance > 0).length,
      newVendors: 2,
      totalAdmins: adminUsers.length,
      userGrowthRate: 0.08,
      userRetentionRate: 0.85,
      averageSessionDuration: 15.5,
      usersByRole: {
        'student': studentUsers.length,
        'vendor': vendorUsers.length,
        'admin': adminUsers.length,
      },
    );
  }

  static VendorAnalytics getVendorAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) {
    final approvedVendors = vendors.where((v) => v.status == 'approved');
    final pendingVendors = vendors.where((v) => v.status == 'pending');
    final suspendedVendors = vendors.where((v) => v.status == 'suspended');
    return VendorAnalytics(
      totalVendors: vendors.length,
      activeVendors: approvedVendors.length,
      pendingVendors: pendingVendors.length,
      suspendedVendors: suspendedVendors.length,
      averageRating: 4.2,
      totalReviews: 1250,
      vendorsByStatus: {
        'approved': approvedVendors.length,
        'pending': pendingVendors.length,
        'suspended': suspendedVendors.length,
      },
      revenueByVendor: {
        'Foodies': 45000.0,
        'Cafe Corner': 32000.0,
        'Quick Bites': 29350.0,
      },
      ordersByVendor: {
        'Foodies': 150,
        'Cafe Corner': 120,
        'Quick Bites': 95,
      },
      topVendors: getTopVendors(period: period, startDate: startDate, endDate: endDate),
    );
  }

  static WalletAnalytics getWalletAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) {
    return WalletAnalytics(
      totalWalletBalance: users.fold(0.0, (sum, user) => sum + user.walletBalance),
      totalTopups: 25000.0,
      totalSpent: 18000.0,
      totalTopupTransactions: 150,
      totalWalletTransactions: 1250,
      averageTopupAmount: 166.67,
      averageWalletBalance: users.isNotEmpty 
          ? users.fold(0.0, (sum, user) => sum + user.walletBalance) / users.length 
          : 0.0,
      topupsByPaymentMethod: {
        'credit_card': 15000.0,
        'debit_card': 8000.0,
        'net_banking': 2000.0,
      },
      recentTransactions: getRecentWalletTransactions(period: period, startDate: startDate, endDate: endDate),
    );
  }

  static OrderAnalytics getOrderAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) {
    return OrderAnalytics(
      totalOrders: orders.length,
      completedOrders: orders.where((o) => o.status == 'completed').length,
      cancelledOrders: orders.where((o) => o.status == 'cancelled').length,
      pendingOrders: orders.where((o) => o.status == 'pending').length,
      averageOrderValue: orders.isNotEmpty 
          ? orders.fold(0.0, (sum, order) => sum + order.totalAmount) / orders.length 
          : 0.0,
      averagePreparationTime: 15.0,
      averageDeliveryTime: 10.5,
      ordersByStatus: {
        'completed': orders.where((o) => o.status == 'completed').length,
        'cancelled': orders.where((o) => o.status == 'cancelled').length,
        'pending': orders.where((o) => o.status == 'pending').length,
        'preparing': orders.where((o) => o.status == 'preparing').length,
        'ready': orders.where((o) => o.status == 'ready').length,
      },
      ordersByHour: List.generate(24, (hour) {
        return MapEntry('$hour:00', (hour >= 11 && hour <= 14) ? 15 : (hour >= 18 && hour <= 21) ? 12 : 5);
      }).fold<Map<String, int>>({}, (map, entry) => map..[entry.key] = entry.value),
      ordersByDay: {
        'Monday': 85,
        'Tuesday': 92,
        'Wednesday': 78,
        'Thursday': 105,
        'Friday': 120,
        'Saturday': 65,
        'Sunday': 45,
      },
    );
  }

  static List<PeakHourData> getPeakHourAnalysis({
    required String period,
    String? startDate,
    String? endDate,
  }) {
    return List.generate(24, (hour) {
      return PeakHourData(
        hour: '$hour:00',
        orderCount: (hour >= 11 && hour <= 14) ? 45 : (hour >= 18 && hour <= 21) ? 38 : 15,
        revenue: (hour >= 11 && hour <= 14) ? 6750.0 : (hour >= 18 && hour <= 21) ? 5700.0 : 2250.0,
        averageOrderValue: 150.0,
      );
    });
  }

  static List<DailyTrend> getDailyTrends({
    required String period,
    String? startDate,
    String? endDate,
  }) {
    return List.generate(30, (days) {
      final date = DateTime.now().subtract(Duration(days: days));
      return DailyTrend(
        date: date.toIso8601String(),
        orders: 120 + (days % 10) * 5,
        revenue: 18000.0 + (days % 10) * 750.0,
        newUsers: 5 + (days % 3),
        activeVendors: 8 + (days % 2),
      );
    });
  }

  static List<CategoryPerformance> getCategoryPerformance({
    required String period,
    String? startDate,
    String? endDate,
  }) {
    return [
      CategoryPerformance(
        category: 'Snacks',
        orders: 450,
        revenue: 33750.0,
        growthRate: 0.12,
        marketShare: 0.25,
      ),
      CategoryPerformance(
        category: 'Main Course',
        orders: 380,
        revenue: 57000.0,
        growthRate: 0.08,
        marketShare: 0.35,
      ),
      CategoryPerformance(
        category: 'Beverages',
        orders: 520,
        revenue: 15600.0,
        growthRate: 0.15,
        marketShare: 0.15,
      ),
    ];
  }

  static List<PaymentMethodAnalytics> getPaymentMethodAnalytics({
    required String period,
    String? startDate,
    String? endDate,
  }) {
    return [
      PaymentMethodAnalytics(
        method: 'Wallet',
        transactionCount: 850,
        totalAmount: 127500.0,
        percentage: 0.75,
      ),
      PaymentMethodAnalytics(
        method: 'Cash',
        transactionCount: 200,
        totalAmount: 30000.0,
        percentage: 0.18,
      ),
      PaymentMethodAnalytics(
        method: 'Card',
        transactionCount: 100,
        totalAmount: 15000.0,
        percentage: 0.07,
      ),
    ];
  }

  static List<TopVendor> getTopVendors({
    required String period,
    int limit = 10,
    String? startDate,
    String? endDate,
  }) {
    return vendors.take(limit).map((vendor) => TopVendor(
      vendorId: vendor.vendorId,
      vendorName: vendor.name,
      orders: 120 + (vendor.vendorId.hashCode % 50),
      revenue: 18000.0 + (vendor.vendorId.hashCode % 5000),
      rating: 4.2 + (vendor.vendorId.hashCode % 8) / 10.0,
    )).toList();
  }

  static List<WalletTransaction> getRecentWalletTransactions({
    String? period,
    String? startDate,
    String? endDate,
    int limit = 50,
    String? userId,
  }) {
    var filteredTransactions = transactions;
    if (userId != null) {
      filteredTransactions = transactions.where((t) => t.userId == userId).toList();
    }
    return filteredTransactions.take(limit).map((transaction) => WalletTransaction(
      transactionId: transaction.transactionId,
      userId: transaction.userId,
      userName: users.firstWhere((u) => u.userId == transaction.userId, orElse: () => users.first).name,
      type: transaction.type,
      amount: transaction.amount,
      paymentMethod: 'wallet',
      timestamp: transaction.createdAt.toIso8601String(),
      status: 'completed',
    )).toList();
  }

  static Map<String, dynamic> getRealTimeDashboardData() {
    return {
      'activeUsers': 45,
      'activeOrders': 12,
      'revenueToday': 8750.0,
      'ordersToday': 58,
      'systemLoad': 0.65,
    };
  }

  static Map<String, dynamic> getCustomReport({
    required List<String> metrics,
    required String period,
    String? startDate,
    String? endDate,
    Map<String, dynamic>? filters,
  }) {
    final analytics = getAnalytics(period: period, startDate: startDate, endDate: endDate);
    return {
      'period': analytics.period,
      'startDate': analytics.startDate,
      'endDate': analytics.endDate,
      'metrics': metrics,
      'data': {
        'totalUsers': analytics.overview.totalUsers,
        'totalVendors': analytics.overview.totalVendors,
        'totalOrders': analytics.overview.totalOrders,
        'totalRevenue': analytics.overview.totalRevenue,
        'totalSales': analytics.sales.totalSales,
        'netSales': analytics.sales.netSales,
        'growthRate': analytics.sales.growthRate,
      },
    };
  }

  static String exportAnalyticsData({
    required String format,
    required String period,
    String? startDate,
    String? endDate,
    List<String>? metrics,
  }) {
    return 'analytics_export_${DateTime.now().millisecondsSinceEpoch}.${format.toLowerCase()}';
  }

  static Map<String, dynamic> getAnalyticsInsights() {
    return {
      'peakHours': [11, 12, 13, 18, 19, 20],
      'topCategories': ['Snacks', 'Main Course', 'Beverages'],
      'revenueGrowth': 0.15,
      'userRetention': 0.85,
    };
  }

  static Map<String, dynamic> comparePeriods({
    required String currentPeriod,
    required String previousPeriod,
  }) {
    return {
      'revenueGrowth': 0.15,
      'orderGrowth': 0.12,
      'userGrowth': 0.08,
      'vendorGrowth': 0.10,
    };
  }

  // Mock Complaints Data
  static final List<ComplaintModel> complaints = [
    ComplaintModel(
      complaintId: 'comp_1',
      complaintType: 'student_complaint',
      submittedBy: 'user_1',
      submittedByName: 'Jash',
      submittedByRole: 'student',
      subject: 'Food quality issue',
      description: 'The food was cold and not fresh',
      status: 'pending',
      priority: 'medium',
      relatedOrderId: 'order_1',
      relatedVendorId: 'vendor_1',
      submittedAt: '2024-01-15T10:30:00Z',
      category: 'food_quality',
    ),
    ComplaintModel(
      complaintId: 'comp_2',
      complaintType: 'vendor_complaint',
      submittedBy: 'user_2',
      submittedByName: 'Foodies Owner',
      submittedByRole: 'vendor',
      subject: 'Payment delay',
      description: 'Payment for order order_2 is delayed',
      status: 'in_progress',
      priority: 'high',
      relatedOrderId: 'order_2',
      relatedUserId: 'user_1',
      submittedAt: '2024-01-14T14:20:00Z',
      assignedTo: 'user_3',
      assignedToName: 'Admin',
      category: 'payment_issue',
    ),
    ComplaintModel(
      complaintId: 'comp_3',
      complaintType: 'feedback',
      submittedBy: 'user_4',
      submittedByName: 'Divy',
      submittedByRole: 'student',
      subject: 'Great service',
      description: 'The food was excellent and service was fast',
      status: 'resolved',
      priority: 'low',
      relatedVendorId: 'vendor_1',
      submittedAt: '2024-01-13T12:15:00Z',
      resolvedAt: '2024-01-13T15:30:00Z',
      resolvedBy: 'user_3',
      resolution: 'Thank you for your feedback!',
      category: 'service',
      rating: 5.0,
    ),
    ComplaintModel(
      complaintId: 'comp_4',
      complaintType: 'student_complaint',
      submittedBy: 'user_1',
      submittedByName: 'Jash',
      submittedByRole: 'student',
      subject: 'App bug',
      description: 'The app crashes when trying to place an order',
      status: 'in_progress',
      priority: 'urgent',
      submittedAt: '2024-01-12T09:45:00Z',
      assignedTo: 'user_3',
      assignedToName: 'Admin',
      category: 'technical',
    ),
    ComplaintModel(
      complaintId: 'comp_5',
      complaintType: 'student_complaint',
      submittedBy: 'user_4',
      submittedByName: 'Divy',
      submittedByRole: 'student',
      subject: 'Wrong order delivered',
      description: 'Received different items than what was ordered',
      status: 'resolved',
      priority: 'high',
      relatedOrderId: 'order_3',
      relatedVendorId: 'vendor_2',
      submittedAt: '2024-01-11T18:20:00Z',
      resolvedAt: '2024-01-12T10:00:00Z',
      resolvedBy: 'user_3',
      resolution: 'Refund processed and vendor notified',
      category: 'order_issue',
    ),
  ];

  // Mock Comments Data
  static final List<CommentModel> comments = [
    CommentModel(
      commentId: 'comment_1',
      complaintId: 'comp_1',
      commentedBy: 'user_3',
      commentedByName: 'Admin',
      commentedByRole: 'admin',
      comment: 'We are investigating this issue with the vendor',
      commentedAt: '2024-01-15T11:00:00Z',
      isInternal: true,
    ),
    CommentModel(
      commentId: 'comment_2',
      complaintId: 'comp_1',
      commentedBy: 'user_2',
      commentedByName: 'Foodies Owner',
      commentedByRole: 'vendor',
      comment: 'We apologize for the inconvenience. We will improve our quality control',
      commentedAt: '2024-01-15T12:30:00Z',
    ),
    CommentModel(
      commentId: 'comment_3',
      complaintId: 'comp_2',
      commentedBy: 'user_3',
      commentedByName: 'Admin',
      commentedByRole: 'admin',
      comment: 'Payment team is looking into this issue',
      commentedAt: '2024-01-14T15:00:00Z',
      isInternal: true,
    ),
    CommentModel(
      commentId: 'comment_4',
      complaintId: 'comp_4',
      commentedBy: 'user_3',
      commentedByName: 'Admin',
      commentedByRole: 'admin',
      comment: 'Development team is working on a fix',
      commentedAt: '2024-01-12T10:00:00Z',
    ),
  ];

  // Helper methods for complaints
  static List<ComplaintModel> getComplaintsByType(String complaintType) {
    return complaints.where((c) => c.complaintType == complaintType).toList();
  }

  static List<ComplaintModel> getComplaintsByStatus(String status) {
    return complaints.where((c) => c.status == status).toList();
  }

  static List<ComplaintModel> getComplaintsByPriority(String priority) {
    return complaints.where((c) => c.priority == priority).toList();
  }

  static List<ComplaintModel> getComplaintsByCategory(String category) {
    return complaints.where((c) => c.category == category).toList();
  }

  static List<ComplaintModel> getComplaintsBySubmitter(String submitterId) {
    return complaints.where((c) => c.submittedBy == submitterId).toList();
  }

  static List<ComplaintModel> getComplaintsByVendor(String vendorId) {
    return complaints.where((c) => c.relatedVendorId == vendorId).toList();
  }

  static List<ComplaintModel> getComplaintsByUser(String userId) {
    return complaints.where((c) => c.relatedUserId == userId).toList();
  }

  static List<CommentModel> getCommentsByComplaint(String complaintId) {
    return comments.where((c) => c.complaintId == complaintId).toList();
  }

  static Map<String, dynamic> getComplaintStatistics() {
    final total = complaints.length;
    final pending = complaints.where((c) => c.status == 'pending').length;
    final inProgress = complaints.where((c) => c.status == 'in_progress').length;
    final resolved = complaints.where((c) => c.status == 'resolved').length;
    final rejected = complaints.where((c) => c.status == 'rejected').length;
    
    return {
      'total': total,
      'pending': pending,
      'in_progress': inProgress,
      'resolved': resolved,
      'rejected': rejected,
      'resolution_rate': resolved / total,
    };
  }

  static Map<String, dynamic> getComplaintTrends({String? period}) {
    return {
      'daily': {'2024-01-15': 2, '2024-01-14': 1, '2024-01-13': 1, '2024-01-12': 1, '2024-01-11': 1},
      'by_category': {
        'food_quality': 1,
        'payment_issue': 1,
        'service': 1,
        'technical': 1,
        'order_issue': 1,
      },
      'by_priority': {
        'urgent': 1,
        'high': 2,
        'medium': 1,
        'low': 1,
      },
    };
  }

  static List<ComplaintModel> searchComplaints(String query) {
    final lowerQuery = query.toLowerCase();
    return complaints.where((c) => 
      c.subject.toLowerCase().contains(lowerQuery) ||
      c.description.toLowerCase().contains(lowerQuery) ||
      c.submittedByName.toLowerCase().contains(lowerQuery)
    ).toList();
  }
}