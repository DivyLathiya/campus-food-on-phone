import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:campus_food_app/presentation/app_router.dart';
import 'package:campus_food_app/data/repositories/mock_auth_repository.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';
import 'package:campus_food_app/presentation/student/bloc/vendor_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/order_bloc.dart' hide LoadVendors; // <-- HIDE the conflicting class
import 'package:campus_food_app/presentation/student/bloc/wallet_bloc.dart';
import 'package:campus_food_app/data/repositories/mock_vendor_repository.dart';
import 'package:campus_food_app/data/repositories/mock_order_repository.dart';
import 'package:campus_food_app/data/repositories/mock_menu_repository.dart';
import 'package:campus_food_app/data/repositories/mock_user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => MockAuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => MockUserRepository(),
        ),
        RepositoryProvider(
          create: (context) => MockVendorRepository(),
        ),
        RepositoryProvider(
          create: (context) => MockOrderRepository(),
        ),
        RepositoryProvider(
          create: (context) => MockMenuRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<MockAuthRepository>(),
            )..add(const AuthCheckStatus()),
          ),
          BlocProvider(
            create: (context) => VendorBloc(
              vendorRepository: context.read<MockVendorRepository>(),
            )..add(const LoadVendors()),
          ),
          BlocProvider(
            create: (context) => OrderBloc(
              orderRepository: context.read<MockOrderRepository>(),
              vendorRepository: context.read<MockVendorRepository>(),
              menuRepository: context.read<MockMenuRepository>(),
              userRepository: context.read<MockUserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => WalletBloc(
              userRepository: context.read<MockUserRepository>(),
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
      ),
    );
  }
}