import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/transaction_entity.dart';
import 'package:campus_food_app/domain/entities/user_entity.dart';
import 'package:campus_food_app/domain/repositories/user_repository.dart';
import 'package:campus_food_app/domain/repositories/notification_repository.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final UserRepository userRepository;
  final NotificationRepository notificationRepository;

  WalletBloc({
    required this.userRepository,
    required this.notificationRepository,
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
        
        // Check for low balance and send reminder
        await _checkAndSendLowBalanceReminder(user);
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
        // Send funds added notification
        await _sendWalletNotification(
          updatedUser.userId,
          'funds_added',
          'Funds Added Successfully',
          '₹${event.amount.toStringAsFixed(2)} has been added to your wallet. New balance: ₹${updatedUser.walletBalance.toStringAsFixed(2)}',
        );
        
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
        // Send funds withdrawn notification
        await _sendWalletNotification(
          updatedUser.userId,
          'funds_withdrawn',
          'Funds Withdrawn',
          '₹${event.amount.toStringAsFixed(2)} has been withdrawn from your wallet for: ${event.reason}. New balance: ₹${updatedUser.walletBalance.toStringAsFixed(2)}',
        );
        
        // Reload wallet balance
        add(LoadWalletBalance(userId: event.userId));
      } else {
        emit(const WalletError(message: 'Failed to withdraw from wallet'));
      }
    } catch (e) {
      emit(WalletError(message: e.toString()));
    }
  }

  Future<void> _checkAndSendLowBalanceReminder(UserEntity user) async {
    try {
      const double lowBalanceThreshold = 100.0; // ₹100 threshold
      
      if (user.walletBalance < lowBalanceThreshold && user.walletBalance > 0) {
        await _sendWalletNotification(
          user.userId,
          'low_balance',
          'Low Wallet Balance',
          'Your wallet balance is running low (₹${user.walletBalance.toStringAsFixed(2)}). Consider adding funds to avoid missing out on orders!',
        );
      } else if (user.walletBalance <= 0) {
        await _sendWalletNotification(
          user.userId,
          'empty_balance',
          'Wallet Balance Empty',
          'Your wallet balance is ₹${user.walletBalance.toStringAsFixed(2)}. Add funds to your wallet to place orders.',
        );
      }
    } catch (e) {
      // Log error but don't fail the wallet operation
      print('Failed to send low balance reminder: ${e.toString()}');
    }
  }

  Future<void> _sendWalletNotification(
    String userId,
    String notificationType,
    String title,
    String message,
  ) async {
    try {
      await notificationRepository.sendWalletReminder(
        userId,
        title,
        message,
      );
    } catch (e) {
      // Log error but don't fail the wallet operation
      print('Failed to send wallet notification: ${e.toString()}');
    }
  }
}
