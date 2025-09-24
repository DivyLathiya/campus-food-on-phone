import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/transaction_entity.dart';
import 'package:campus_food_app/domain/repositories/user_repository.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final UserRepository userRepository;

  WalletBloc({
    required this.userRepository,
  }) : super(const WalletInitial()) {
    on<LoadWalletBalance>(_onLoadWalletBalance);
    on<AddFundsToWallet>(_onAddFundsToWallet);
    on<GetTransactionHistory>(_onGetTransactionHistory);
    on<WithdrawFromWallet>(_onWithdrawFromWallet);
  }

  Future<void> _onLoadWalletBalance(
    LoadWalletBalance event,
    Emitter<WalletState> emit,
  ) async {
    emit(const WalletLoading());
    try {
      final user = await userRepository.getUserById(event.userId);
      if (user != null) {
        emit(WalletBalanceLoaded(
          userId: user.userId,
          balance: user.walletBalance,
        ));
      } else {
        emit(const WalletError(message: 'User not found'));
      }
    } catch (e) {
      emit(WalletError(message: e.toString()));
    }
  }

  Future<void> _onAddFundsToWallet(
    AddFundsToWallet event,
    Emitter<WalletState> emit,
  ) async {
    emit(const WalletLoading());
    try {
      final updatedUser = await userRepository.addFundsToWallet(
        event.userId,
        event.amount,
        event.paymentMethod,
      );
      
      if (updatedUser.walletBalance >= 0) {
        // Reload wallet balance
        add(LoadWalletBalance(userId: event.userId));
      } else {
        emit(const WalletError(message: 'Failed to add funds to wallet'));
      }
    } catch (e) {
      emit(WalletError(message: e.toString()));
    }
  }

  Future<void> _onGetTransactionHistory(
    GetTransactionHistory event,
    Emitter<WalletState> emit,
  ) async {
    emit(const WalletLoading());
    try {
      final transactions = await userRepository.getTransactionHistory(event.userId);
      emit(TransactionHistoryLoaded(
        userId: event.userId,
        transactions: transactions,
      ));
    } catch (e) {
      emit(WalletError(message: e.toString()));
    }
  }

  Future<void> _onWithdrawFromWallet(
    WithdrawFromWallet event,
    Emitter<WalletState> emit,
  ) async {
    emit(const WalletLoading());
    try {
      final updatedUser = await userRepository.withdrawFromWallet(
        event.userId,
        event.amount,
        event.reason,
      );
      
      if (updatedUser.walletBalance >= 0) {
        // Reload wallet balance
        add(LoadWalletBalance(userId: event.userId));
      } else {
        emit(const WalletError(message: 'Failed to withdraw from wallet'));
      }
    } catch (e) {
      emit(WalletError(message: e.toString()));
    }
  }
}
