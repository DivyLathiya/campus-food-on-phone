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