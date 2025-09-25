import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:campus_food_app/presentation/app_router.dart';
import 'package:campus_food_app/data/repositories/mock_auth_repository.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';
import 'package:campus_food_app/presentation/student/bloc/vendor_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/order_bloc.dart' hide LoadVendors; // <-- HIDE the conflicting class
import 'package:campus_food_app/presentation/vendor/bloc/order_bloc.dart' as VendorOrderBloc;
import 'package:campus_food_app/presentation/student/bloc/wallet_bloc.dart';
import 'package:campus_food_app/presentation/vendor/bloc/menu_bloc.dart';
import 'package:campus_food_app/presentation/vendor/bloc/sales_report_bloc.dart';
import 'package:campus_food_app/presentation/vendor/bloc/discount_bloc.dart';
import 'package:campus_food_app/presentation/vendor/bloc/enhanced_discount_bloc.dart';
import 'package:campus_food_app/presentation/vendor/bloc/pickup_slot_bloc.dart';
import 'package:campus_food_app/presentation/admin/bloc/admin_message_bloc.dart';
import 'package:campus_food_app/data/repositories/mock_vendor_repository.dart';
import 'package:campus_food_app/data/repositories/mock_order_repository.dart';
import 'package:campus_food_app/data/repositories/mock_menu_repository.dart';
import 'package:campus_food_app/data/repositories/mock_user_repository.dart';
import 'package:campus_food_app/data/repositories/mock_sales_report_repository.dart';
import 'package:campus_food_app/data/repositories/mock_discount_repository.dart';
import 'package:campus_food_app/data/repositories/mock_enhanced_discount_repository.dart';
import 'package:campus_food_app/data/repositories/mock_pickup_slot_repository.dart';
import 'package:campus_food_app/data/repositories/mock_notification_repository.dart';

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
        RepositoryProvider(
          create: (context) => MockSalesReportRepository(),
        ),
        RepositoryProvider(
          create: (context) => MockDiscountRepository(),
        ),
        RepositoryProvider(
          create: (context) => MockEnhancedDiscountRepository(),
        ),
        RepositoryProvider(
          create: (context) => MockPickupSlotRepository(),
        ),
        RepositoryProvider(
          create: (context) => MockNotificationRepository(),
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
              pickupSlotRepository: context.read<MockPickupSlotRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => WalletBloc(
              userRepository: context.read<MockUserRepository>(),
              notificationRepository: context.read<MockNotificationRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => VendorOrderBloc.OrderBloc(
              orderRepository: context.read<MockOrderRepository>(),
              userRepository: context.read<MockUserRepository>(),
              menuRepository: context.read<MockMenuRepository>(),
              notificationRepository: context.read<MockNotificationRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => MenuBloc(
              menuRepository: context.read<MockMenuRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SalesReportBloc(
              salesReportRepository: context.read<MockSalesReportRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => DiscountBloc(
              discountRepository: context.read<MockDiscountRepository>(),
              notificationRepository: context.read<MockNotificationRepository>(),
              userRepository: context.read<MockUserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => EnhancedDiscountBloc(
              enhancedDiscountRepository: context.read<MockEnhancedDiscountRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => PickupSlotBloc(
              pickupSlotRepository: context.read<MockPickupSlotRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => AdminMessageBloc(
              notificationRepository: context.read<MockNotificationRepository>(),
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