part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {
  const WalletInitial();
}

class WalletLoading extends WalletState {
  const WalletLoading();
}

class WalletError extends WalletState {
  final String message;

  const WalletError({required this.message});

  @override
  List<Object> get props => [message];
}

class WalletBalanceLoaded extends WalletState {
  final String userId;
  final double balance;

  const WalletBalanceLoaded({
    required this.userId,
    required this.balance,
  });

  @override
  List<Object> get props => [userId, balance];
}

class TransactionHistoryLoaded extends WalletState {
  final String userId;
  final List<TransactionEntity> transactions;

  const TransactionHistoryLoaded({
    required this.userId,
    required this.transactions,
  });

  @override
  List<Object> get props => [userId, transactions];
}

class WalletTransactionSuccess extends WalletState {
  final String message;
  final double newBalance;

  const WalletTransactionSuccess({
    required this.message,
    required this.newBalance,
  });

  @override
  List<Object> get props => [message, newBalance];
}
