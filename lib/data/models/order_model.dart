import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/order_entity.dart';

class OrderItemModel {
  final String menuItemId;
  final String name;
  final double price;
  final int quantity;
  final String? notes;

  OrderItemModel({
    required this.menuItemId,
    required this.name,
    required this.price,
    required this.quantity,
    this.notes,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      menuItemId: json['menuItemId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuItemId': menuItemId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'notes': notes,
    };
  }

  double get totalPrice => price * quantity;

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return OrderItemModel(
      menuItemId: entity.menuItemId,
      name: entity.name,
      price: entity.price,
      quantity: entity.quantity,
      notes: entity.notes,
    );
  }

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      menuItemId: menuItemId,
      name: name,
      price: price,
      quantity: quantity,
      notes: notes,
    );
  }
}

class OrderModel extends Equatable {
  final String orderId;
  final String studentId;
  final String vendorId;
  final List<OrderItemModel> items;
  final double totalAmount;
  final String status;
  final DateTime pickupSlot;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? specialInstructions;
  final double? discountAmount;
  final String? discountId;
  final String paymentMethod;
  final DateTime? cancelledAt;
  final String? cancellationReason;
  final bool isRefunded;
  final DateTime? refundedAt;
  final String? refundReason;

  const OrderModel({
    required this.orderId,
    required this.studentId,
    required this.vendorId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.pickupSlot,
    required this.createdAt,
    this.updatedAt,
    this.specialInstructions,
    this.discountAmount,
    this.discountId,
    this.paymentMethod = 'other',
    this.cancelledAt,
    this.cancellationReason,
    this.isRefunded = false,
    this.refundedAt,
    this.refundReason,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] as String,
      studentId: json['studentId'] as String,
      vendorId: json['vendorId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      status: json['status'] as String,
      pickupSlot: DateTime.parse(json['pickupSlot'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      specialInstructions: json['specialInstructions'] as String?,
      discountAmount: json['discountAmount'] != null 
          ? (json['discountAmount'] as num).toDouble()
          : null,
      discountId: json['discountId'] as String?,
      paymentMethod: json['paymentMethod'] as String? ?? 'other',
      cancelledAt: json['cancelledAt'] != null 
          ? DateTime.parse(json['cancelledAt'] as String)
          : null,
      cancellationReason: json['cancellationReason'] as String?,
      isRefunded: json['isRefunded'] as bool? ?? false,
      refundedAt: json['refundedAt'] != null 
          ? DateTime.parse(json['refundedAt'] as String)
          : null,
      refundReason: json['refundReason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'studentId': studentId,
      'vendorId': vendorId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'specialInstructions': specialInstructions,
      'discountAmount': discountAmount,
      'discountId': discountId,
      'paymentMethod': paymentMethod,
      'cancelledAt': cancelledAt?.toIso8601String(),
      'cancellationReason': cancellationReason,
      'isRefunded': isRefunded,
      'refundedAt': refundedAt?.toIso8601String(),
      'refundReason': refundReason,
    };
  }

  OrderModel copyWith({
    String? orderId,
    String? studentId,
    String? vendorId,
    List<OrderItemModel>? items,
    double? totalAmount,
    String? status,
    DateTime? pickupSlot,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? specialInstructions,
    double? discountAmount,
    String? discountId,
    String? paymentMethod,
    DateTime? cancelledAt,
    String? cancellationReason,
    bool? isRefunded,
    DateTime? refundedAt,
    String? refundReason,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      studentId: studentId ?? this.studentId,
      vendorId: vendorId ?? this.vendorId,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      pickupSlot: pickupSlot ?? this.pickupSlot,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      discountAmount: discountAmount ?? this.discountAmount,
      discountId: discountId ?? this.discountId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      isRefunded: isRefunded ?? this.isRefunded,
      refundedAt: refundedAt ?? this.refundedAt,
      refundReason: refundReason ?? this.refundReason,
    );
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      orderId: entity.orderId,
      studentId: entity.studentId,
      vendorId: entity.vendorId,
      items: entity.items.map((item) => OrderItemModel.fromEntity(item)).toList(),
      totalAmount: entity.totalAmount,
      status: entity.status,
      pickupSlot: entity.pickupSlot,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      specialInstructions: entity.specialInstructions,
      discountAmount: entity.discountAmount,
      discountId: entity.discountId,
      paymentMethod: entity.paymentMethod,
      cancelledAt: entity.cancelledAt,
      cancellationReason: entity.cancellationReason,
      isRefunded: entity.isRefunded,
      refundedAt: entity.refundedAt,
      refundReason: entity.refundReason,
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      orderId: orderId,
      studentId: studentId,
      vendorId: vendorId,
      items: items.map((item) => item.toEntity()).toList(),
      totalAmount: totalAmount,
      status: status,
      pickupSlot: pickupSlot,
      createdAt: createdAt,
      updatedAt: updatedAt,
      specialInstructions: specialInstructions,
      discountAmount: discountAmount,
      discountId: discountId,
      paymentMethod: paymentMethod,
      cancelledAt: cancelledAt,
      cancellationReason: cancellationReason,
      isRefunded: isRefunded,
      refundedAt: refundedAt,
      refundReason: refundReason,
    );
  }

  @override
  List<Object?> get props => [
        orderId,
        studentId,
        vendorId,
        items,
        totalAmount,
        status,
        pickupSlot,
        createdAt,
        updatedAt,
        specialInstructions,
        discountAmount,
        discountId,
        paymentMethod,
        cancelledAt,
        cancellationReason,
        isRefunded,
        refundedAt,
        refundReason,
      ];
}
