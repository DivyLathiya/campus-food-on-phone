import 'package:campus_food_app/data/datasources/mock_data_source.dart';
import 'package:campus_food_app/domain/entities/user_entity.dart';
import 'package:campus_food_app/domain/entities/transaction_entity.dart';
import 'package:campus_food_app/domain/repositories/user_repository.dart';

class MockUserRepository implements UserRepository {
  @override
  Future<UserEntity?> getUserById(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final user = MockDataSource.getUserById(userId);
    if (user != null) {
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
  Future<UserEntity> updateUser(UserEntity user) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Find and update the user in the mock data
    final index = MockDataSource.users.indexWhere((u) => u.userId == user.userId);
    if (index != -1) {
      final updatedUser = MockDataSource.users[index].copyWith(
        walletBalance: user.walletBalance,
        name: user.name,
        phoneNumber: user.phoneNumber,
        profileImageUrl: user.profileImageUrl,
      );
      
      MockDataSource.users[index] = updatedUser;
      
      return UserEntity(
        userId: updatedUser.userId,
        email: updatedUser.email,
        campusId: updatedUser.campusId,
        role: updatedUser.role,
        name: updatedUser.name,
        walletBalance: updatedUser.walletBalance,
        phoneNumber: updatedUser.phoneNumber,
        profileImageUrl: updatedUser.profileImageUrl,
      );
    }
    
    throw Exception('User not found');
  }

  @override
  Future<double> updateWalletBalance(String userId, double amount) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.users.indexWhere((u) => u.userId == userId);
    if (index != -1) {
      final currentBalance = MockDataSource.users[index].walletBalance;
      final newBalance = currentBalance + amount;
      
      // Update the user's wallet balance
      MockDataSource.users[index] = MockDataSource.users[index].copyWith(
        walletBalance: newBalance,
      );
      
      return newBalance;
    }
    
    throw Exception('User not found');
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    return MockDataSource.users.map((user) => UserEntity(
      userId: user.userId,
      email: user.email,
      campusId: user.campusId,
      role: user.role,
      name: user.name,
      walletBalance: user.walletBalance,
      phoneNumber: user.phoneNumber,
      profileImageUrl: user.profileImageUrl,
    )).toList();
  }

  @override
  Future<UserEntity> addFundsToWallet(String userId, double amount, String paymentMethod) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.users.indexWhere((u) => u.userId == userId);
    if (index != -1) {
      final currentBalance = MockDataSource.users[index].walletBalance;
      final newBalance = currentBalance + amount;
      
      // Update the user's wallet balance
      MockDataSource.users[index] = MockDataSource.users[index].copyWith(
        walletBalance: newBalance,
      );
      
      return UserEntity(
        userId: MockDataSource.users[index].userId,
        email: MockDataSource.users[index].email,
        campusId: MockDataSource.users[index].campusId,
        role: MockDataSource.users[index].role,
        name: MockDataSource.users[index].name,
        walletBalance: newBalance,
        phoneNumber: MockDataSource.users[index].phoneNumber,
        profileImageUrl: MockDataSource.users[index].profileImageUrl,
      );
    }
    
    throw Exception('User not found');
  }

  @override
  Future<UserEntity> withdrawFromWallet(String userId, double amount, String reason) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.users.indexWhere((u) => u.userId == userId);
    if (index != -1) {
      final currentBalance = MockDataSource.users[index].walletBalance;
      if (currentBalance < amount) {
        throw Exception('Insufficient funds');
      }
      
      final newBalance = currentBalance - amount;
      
      // Update the user's wallet balance
      MockDataSource.users[index] = MockDataSource.users[index].copyWith(
        walletBalance: newBalance,
      );
      
      return UserEntity(
        userId: MockDataSource.users[index].userId,
        email: MockDataSource.users[index].email,
        campusId: MockDataSource.users[index].campusId,
        role: MockDataSource.users[index].role,
        name: MockDataSource.users[index].name,
        walletBalance: newBalance,
        phoneNumber: MockDataSource.users[index].phoneNumber,
        profileImageUrl: MockDataSource.users[index].profileImageUrl,
      );
    }
    
    throw Exception('User not found');
  }

  @override
  Future<List<TransactionEntity>> getTransactionHistory(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Mock transaction history
    return [
      TransactionEntity(
        transactionId: 'txn_1',
        userId: userId,
        type: 'credit',
        amount: 50.0,
        balanceBefore: 100.0,
        balanceAfter: 150.0,
        description: 'Added funds via credit card',
        status: 'success',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        paymentMethod: 'credit_card',
      ),
      TransactionEntity(
        transactionId: 'txn_2',
        userId: userId,
        type: 'debit',
        amount: 25.0,
        balanceBefore: 150.0,
        balanceAfter: 125.0,
        description: 'Order payment',
        status: 'success',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        referenceId: 'order_123',
      ),
    ];
  }
}
