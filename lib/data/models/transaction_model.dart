import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final String transactionId;
  final String userId;
  final double amount;
  final String type;
  final String status;
  final DateTime createdAt;
  final String? description;
  final String? orderId;
  final String? referenceId;

  const TransactionModel({
    required this.transactionId,
    required this.userId,
    required this.amount,
    required this.type,
    required this.status,
    required this.createdAt,
    this.description,
    this.orderId,
    this.referenceId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionId: json['transactionId'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      description: json['description'] as String?,
      orderId: json['orderId'] as String?,
      referenceId: json['referenceId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'userId': userId,
      'amount': amount,
      'type': type,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'description': description,
      'orderId': orderId,
      'referenceId': referenceId,
    };
  }

  TransactionModel copyWith({
    String? transactionId,
    String? userId,
    double? amount,
    String? type,
    String? status,
    DateTime? createdAt,
    String? description,
    String? orderId,
    String? referenceId,
  }) {
    return TransactionModel(
      transactionId: transactionId ?? this.transactionId,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      orderId: orderId ?? this.orderId,
      referenceId: referenceId ?? this.referenceId,
    );
  }

  @override
  List<Object?> get props {
    return [
      transactionId,
      userId,
      amount,
      type,
      status,
      createdAt,
      description,
      orderId,
      referenceId,
    ];
  }
}
