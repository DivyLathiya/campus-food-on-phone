part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class LoadWalletBalance extends WalletEvent {
  final String userId;

  const LoadWalletBalance({required this.userId});

  @override
  List<Object> get props => [userId];
}

class AddFundsToWallet extends WalletEvent {
  final String userId;
  final double amount;
  final String paymentMethod;

  const AddFundsToWallet({
    required this.userId,
    required this.amount,
    required this.paymentMethod,
  });

  @override
  List<Object> get props => [userId, amount, paymentMethod];
}

class GetTransactionHistory extends WalletEvent {
  final String userId;

  const GetTransactionHistory({required this.userId});

  @override
  List<Object> get props => [userId];
}

class WithdrawFromWallet extends WalletEvent {
  final String userId;
  final double amount;
  final String reason;

  const WithdrawFromWallet({
    required this.userId,
    required this.amount,
    required this.reason,
  });

  @override
  List<Object> get props => [userId, amount, reason];
}
