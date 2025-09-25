import 'package:flutter/material.dart';
import 'package:campus_food_app/presentation/auth/screens/login_screen.dart';
import 'package:campus_food_app/presentation/student/screens/student_home_screen.dart';
import 'package:campus_food_app/presentation/vendor/screens/vendor_home_screen.dart' as vendor;
import 'package:campus_food_app/presentation/admin/screens/admin_home_screen.dart' as admin;
import 'package:campus_food_app/presentation/auth/screens/splash_screen.dart';
import 'package:campus_food_app/presentation/student/screens/vendor_list_screen.dart';
import 'package:campus_food_app/presentation/student/screens/menu_screen.dart';
import 'package:campus_food_app/presentation/student/screens/cart_screen.dart';
import 'package:campus_food_app/presentation/student/screens/checkout_screen.dart';
import 'package:campus_food_app/presentation/student/screens/order_history_screen.dart';
import 'package:campus_food_app/presentation/student/screens/wallet_screen.dart';
import 'package:campus_food_app/domain/entities/vendor_entity.dart';
import 'package:campus_food_app/domain/entities/order_entity.dart';
import 'package:campus_food_app/presentation/student/screens/order_screen.dart';
import 'package:campus_food_app/presentation/student/screens/pickup_slot_screen.dart';
import 'package:campus_food_app/presentation/student/screens/order_details_screen.dart';
import 'package:campus_food_app/presentation/student/screens/feedback_screen.dart';
import 'package:campus_food_app/presentation/vendor/screens/discount_management_screen.dart';
import 'package:campus_food_app/presentation/vendor/screens/menu_management_screen.dart';
import 'package:campus_food_app/presentation/vendor/screens/order_management_screen.dart';
import 'package:campus_food_app/presentation/vendor/screens/pickup_slot_control_screen.dart';
import 'package:campus_food_app/presentation/vendor/screens/sales_reports_screen.dart';
import 'package:campus_food_app/presentation/admin/screens/admin_message_screen.dart';
import 'package:campus_food_app/presentation/admin/screens/vendor_management_screen.dart';
import 'package:campus_food_app/presentation/student/screens/notification_screen.dart';
import 'package:campus_food_app/domain/entities/user_entity.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/student/home':
        return MaterialPageRoute(builder: (_) => const StudentHomeScreen());
      case '/student/order':
        return MaterialPageRoute(builder: (_) => const OrderScreen());
      case '/student/vendors':
        return MaterialPageRoute(builder: (_) => const VendorListScreen());
      case '/student/menu':
        final vendor = settings.arguments as VendorEntity;
        return MaterialPageRoute(builder: (_) => MenuScreen(vendor: vendor));
      case '/student/cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case '/student/checkout':
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case '/student/order-history':
        return MaterialPageRoute(builder: (_) => const OrderHistoryScreen());
      case '/student/order-details':
        final order = settings.arguments as OrderEntity;
        return MaterialPageRoute(builder: (_) => OrderDetailsScreen(order: order));
      case '/student/wallet':
        return MaterialPageRoute(builder: (_) => const WalletScreen());
      case '/student/pickup-slot':
        final vendorId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => PickupSlotScreen(vendorId: vendorId));
      case '/student/feedback':
        final vendorId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => FeedbackScreen(vendorId: vendorId));
      case '/student/notifications':
        final user = settings.arguments as UserEntity;
        return MaterialPageRoute(builder: (_) => NotificationScreen(user: user));
      case '/vendor/home':
        return MaterialPageRoute(builder: (_) => const vendor.VendorHomeScreen());
      case '/vendor/discounts':
        return MaterialPageRoute(builder: (_) => const DiscountManagementScreen());
      case '/vendor/menu':
        return MaterialPageRoute(builder: (_) => const MenuManagementScreen());
      case '/vendor/orders':
        return MaterialPageRoute(builder: (_) => const OrderManagementScreen());
      case '/vendor/pickup-slots':
        final vendorId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => PickupSlotControlScreen(vendorId: vendorId));
      case '/vendor/sales-reports':
        final vendorId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => SalesReportsScreen(vendorId: vendorId));
      case '/admin/home':
        return MaterialPageRoute(builder: (_) => const admin.AdminHomeScreen());
      case '/admin/messages':
        return MaterialPageRoute(builder: (_) => const AdminMessageScreen());
      case '/admin/vendors':
        return MaterialPageRoute(builder: (_) => const VendorManagementScreen());
      case '/admin/analytics':
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.analytics, size: 64, color: Colors.blue),
                  const SizedBox(height: 16),
                  const Text(
                    'Analytics Dashboard',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Analytics dashboard coming soon!'),
                ],
              ),
            ),
          ),
        );
      case '/admin/complaints':
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.feedback, size: 64, color: Colors.orange),
                  const SizedBox(height: 16),
                  const Text(
                    'Complaint Management',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Complaint management coming soon!'),
                ],
              ),
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

