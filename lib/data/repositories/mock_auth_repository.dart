import 'package:campus_food_app/data/datasources/mock_data_source.dart';
import 'package:campus_food_app/data/models/user_model.dart';
import 'package:campus_food_app/domain/entities/user_entity.dart';
import 'package:campus_food_app/domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  UserModel? _currentUser;

  @override
  Future<UserEntity?> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // In a real app, we would verify the password
    // For mock purposes, we'll accept any non-empty password
    if (email.isEmpty || password.isEmpty) {
      return null;
    }

    final user = MockDataSource.getUserByEmail(email);
    if (user != null) {
      _currentUser = user;
      return UserEntity(
        userId: user.userId,
        email: user.email,
        campusId: user.campusId,
        role: user.role,
        name: user.name,
        walletBalance: user.walletBalance,
        phoneNumber: user.phoneNumber,
        profileImageUrl: user.profileImageUrl,
      );
    }
    
    return null;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _currentUser = null;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    if (_currentUser != null) {
      return UserEntity(
        userId: _currentUser!.userId,
        email: _currentUser!.email,
        campusId: _currentUser!.campusId,
        role: _currentUser!.role,
        name: _currentUser!.name,
        walletBalance: _currentUser!.walletBalance,
        phoneNumber: _currentUser!.phoneNumber,
        profileImageUrl: _currentUser!.profileImageUrl,
      );
    }
    
    return null;
  }

  @override
  Future<bool> isLoggedIn() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _currentUser != null;
  }
}
