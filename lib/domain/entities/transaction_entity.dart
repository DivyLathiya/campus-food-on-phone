import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String transactionId;
  final String userId;
  final String type; // 'credit' or 'debit'
  final double amount;
  final double balanceBefore;
  final double balanceAfter;
  final String description;
  final String status; // 'success', 'failed', 'pending'
  final DateTime createdAt;
  final String? referenceId;
  final String? paymentMethod;

  const TransactionEntity({
    required this.transactionId,
    required this.userId,
    required this.type,
    required this.amount,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.description,
    required this.status,
    required this.createdAt,
    this.referenceId,
    this.paymentMethod,
  });

  @override
  List<Object?> get props {
    return [
      transactionId,
      userId,
      type,
      amount,
      balanceBefore,
      balanceAfter,
      description,
      status,
      createdAt,
      referenceId,
      paymentMethod,
    ];
  }
}
