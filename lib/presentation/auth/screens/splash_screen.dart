import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          switch (state.role) {
            case 'student':
              Navigator.of(context).pushReplacementNamed('/student/home');
              break;
            case 'vendor':
              Navigator.of(context).pushReplacementNamed('/vendor/home');
              break;
            case 'admin':
              Navigator.of(context).pushReplacementNamed('/admin/home');
              break;
            default:
              Navigator.of(context).pushReplacementNamed('/login');
          }
        } else if (state is AuthUnauthenticated || state is AuthError) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}