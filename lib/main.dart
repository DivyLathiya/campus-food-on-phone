import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:campus_food_app/presentation/app_router.dart';
import 'package:campus_food_app/data/repositories/mock_auth_repository.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authRepository: MockAuthRepository(),
      )..add(const AuthCheckStatus()),
      child: MaterialApp(
        title: 'Campus Food App',
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: '/', // Make sure the initial route is set
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}