import 'package:campus_food_app/domain/entities/user_entity.dart';
import 'package:campus_food_app/domain/entities/transaction_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getUserById(String userId);
  Future<UserEntity> updateUser(UserEntity user);
  Future<double> updateWalletBalance(String userId, double amount);
  Future<UserEntity> addFundsToWallet(String userId, double amount, String paymentMethod);
  Future<UserEntity> withdrawFromWallet(String userId, double amount, String reason);
  Future<List<TransactionEntity>> getTransactionHistory(String userId);
  Future<List<UserEntity>> getAllUsers();
}
