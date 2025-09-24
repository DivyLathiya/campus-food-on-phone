import 'package:flutter/material.dart';
import 'package:campus_food_app/presentation/auth/screens/login_screen.dart';
import 'package:campus_food_app/presentation/student/screens/student_home_screen.dart';
import 'package:campus_food_app/presentation/vendor/screens/vendor_home_screen.dart';
import 'package:campus_food_app/presentation/admin/screens/admin_home_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/student/home':
        return MaterialPageRoute(builder: (_) => const StudentHomeScreen());
      case '/vendor/home':
        return MaterialPageRoute(builder: (_) => const VendorHomeScreen());
      case '/admin/home':
        return MaterialPageRoute(builder: (_) => const AdminHomeScreen());
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
