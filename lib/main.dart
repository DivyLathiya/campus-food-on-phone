import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:campus_food_app/presentation/app_router.dart';
import 'package:campus_food_app/data/repositories/mock_auth_repository.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';
import 'package:campus_food_app/presentation/student/bloc/vendor_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/order_bloc.dart' hide LoadVendors; // <-- HIDE the conflicting class
import 'package:campus_food_app/data/repositories/mock_vendor_repository.dart';
import 'package:campus_food_app/data/repositories/mock_order_repository.dart';
import 'package:campus_food_app/data/repositories/mock_menu_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: MockAuthRepository(),
          )..add(const AuthCheckStatus()),
        ),
        BlocProvider(
          create: (context) => VendorBloc(
            vendorRepository: MockVendorRepository(),
          )..add(const LoadVendors()),
        ),
        BlocProvider(
          create: (context) => OrderBloc(
            orderRepository: MockOrderRepository(),
            vendorRepository: MockVendorRepository(),
            menuRepository: MockMenuRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Campus Food App',
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}