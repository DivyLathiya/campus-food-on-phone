import 'package:campus_food_app/data/models/user_model.dart';
import 'package:campus_food_app/data/models/vendor_model.dart';
import 'package:campus_food_app/data/models/menu_item_model.dart';
import 'package:campus_food_app/data/models/discount_model.dart';
import 'package:campus_food_app/data/models/order_model.dart';
import 'package:campus_food_app/data/models/transaction_model.dart';
import 'package:campus_food_app/core/utils/app_constants.dart';

class MockDataSource {
  // Mock Users
  static final List<UserModel> users = [
    UserModel(
      userId: 'user_1',
      email: 'student@campus.edu',
      campusId: 'STU001',
      role: AppConstants.roleStudent,
      name: 'John Student',
      walletBalance: 50.00,
      phoneNumber: '+1234567890',
    ),
    UserModel(
      userId: 'user_2',
      email: 'vendor1@campus.edu',
      campusId: 'VEN001',
      role: AppConstants.roleVendor,
      name: 'Pizza Palace Owner',
      walletBalance: 1000.00,
      phoneNumber: '+1234567891',
    ),
    UserModel(
      userId: 'user_3',
      email: 'admin@campus.edu',
      campusId: 'ADM001',
      role: AppConstants.roleAdmin,
      name: 'Campus Admin',
      walletBalance: 0.00,
      phoneNumber: '+1234567892',
    ),
    UserModel(
      userId: 'user_4',
      email: 'student2@campus.edu',
      campusId: 'STU002',
      role: AppConstants.roleStudent,
      name: 'Jane Student',
      walletBalance: 75.50,
      phoneNumber: '+1234567893',
    ),
  ];

  // Mock Vendors
  static final List<VendorModel> vendors = [
    VendorModel(
      vendorId: 'vendor_1',
      name: 'Pizza Palace',
      description: 'Fresh pizzas made with love',
      imageUrl: 'assets/images/pizza_palace.jpg',
      status: AppConstants.vendorOpen,
      rating: 4.5,
      reviewCount: 120,
      location: 'Main Campus - Building A',
      phoneNumber: '+1234567890',
      ownerId: 'user_2',
    ),
    VendorModel(
      vendorId: 'vendor_2',
      name: 'Burger Barn',
      description: 'Juicy burgers and fries',
      imageUrl: 'assets/images/burger_barn.jpg',
      status: AppConstants.vendorOpen,
      rating: 4.2,
      reviewCount: 85,
      location: 'Main Campus - Building B',
      phoneNumber: '+1234567891',
      ownerId: 'user_5',
    ),
    VendorModel(
      vendorId: 'vendor_3',
      name: 'Sushi Station',
      description: 'Fresh Japanese cuisine',
      imageUrl: 'assets/images/sushi_station.jpg',
      status: AppConstants.vendorPendingApproval,
      rating: 0.0,
      reviewCount: 0,
      location: 'Main Campus - Building C',
      phoneNumber: '+1234567892',
      ownerId: 'user_6',
    ),
    VendorModel(
      vendorId: 'vendor_4',
      name: 'Taco Time',
      description: 'Authentic Mexican tacos',
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
    MenuItemModel(
      menuItemId: 'menu_1',
      vendorId: 'vendor_1',
      name: 'Margherita Pizza',
      description: 'Classic pizza with tomato sauce and mozzarella',
      price: 12.99,
      imageUrl: 'assets/images/margherita_pizza.jpg',
      isAvailable: true,
      category: 'Pizza',
      preparationTime: 15,
      tags: ['vegetarian', 'classic'],
    ),
    MenuItemModel(
      menuItemId: 'menu_2',
      vendorId: 'vendor_1',
      name: 'Pepperoni Pizza',
      description: 'Pizza with pepperoni and mozzarella',
      price: 14.99,
      imageUrl: 'assets/images/pepperoni_pizza.jpg',
      isAvailable: true,
      category: 'Pizza',
      preparationTime: 15,
      tags: ['popular', 'meat'],
    ),
    MenuItemModel(
      menuItemId: 'menu_3',
      vendorId: 'vendor_2',
      name: 'Classic Burger',
      description: 'Beef burger with lettuce, tomato, and cheese',
      price: 8.99,
      imageUrl: 'assets/images/classic_burger.jpg',
      isAvailable: true,
      category: 'Burgers',
      preparationTime: 10,
      tags: ['popular', 'beef'],
    ),
    MenuItemModel(
      menuItemId: 'menu_4',
      vendorId: 'vendor_2',
      name: 'Cheeseburger',
      description: 'Beef burger with extra cheese',
      price: 9.99,
      imageUrl: 'assets/images/cheeseburger.jpg',
      isAvailable: true,
      category: 'Burgers',
      preparationTime: 10,
      tags: ['cheese', 'beef'],
    ),
    MenuItemModel(
      menuItemId: 'menu_5',
      vendorId: 'vendor_3',
      name: 'California Roll',
      description: 'Crab, avocado, and cucumber roll',
      price: 10.99,
      imageUrl: 'assets/images/california_roll.jpg',
      isAvailable: false,
      category: 'Sushi',
      preparationTime: 20,
      tags: ['sushi', 'raw fish'],
    ),
    MenuItemModel(
      menuItemId: 'menu_6',
      vendorId: 'vendor_4',
      name: 'Beef Taco',
      description: 'Ground beef taco with fresh toppings',
      price: 6.99,
      imageUrl: 'assets/images/beef_taco.jpg',
      isAvailable: true,
      category: 'Tacos',
      preparationTime: 8,
      tags: ['mexican', 'beef'],
    ),
  ];

  // Mock Discounts
  static final List<DiscountModel> discounts = [
    DiscountModel(
      discountId: 'discount_1',
      vendorId: 'vendor_1',
      type: AppConstants.discountPercentage,
      value: 10.0,
      description: '10% off on all pizzas',
      minOrderAmount: 20.0,
      isActive: true,
    ),
    DiscountModel(
      discountId: 'discount_2',
      vendorId: 'vendor_2',
      type: AppConstants.discountFixed,
      value: 2.0,
      description: '\$2 off on burgers',
      minOrderAmount: 10.0,
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
          price: 12.99,
          quantity: 1,
        ),
      ],
      totalAmount: 12.99,
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
          name: 'Classic Burger',
          price: 8.99,
          quantity: 2,
        ),
      ],
      totalAmount: 17.98,
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
      amount: 50.00,
      type: AppConstants.transactionCredit,
      status: AppConstants.transactionSuccess,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      description: 'Wallet top-up',
    ),
    TransactionModel(
      transactionId: 'txn_2',
      userId: 'user_1',
      amount: 12.99,
      type: AppConstants.transactionDebit,
      status: AppConstants.transactionSuccess,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      description: 'Order payment',
      orderId: 'order_1',
    ),
    TransactionModel(
      transactionId: 'txn_3',
      userId: 'user_4',
      amount: 75.50,
      type: AppConstants.transactionCredit,
      status: AppConstants.transactionSuccess,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      description: 'Wallet top-up',
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
}
