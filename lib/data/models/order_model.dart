import 'package:equatable/equatable.dart';

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
      'pickupSlot': pickupSlot.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'specialInstructions': specialInstructions,
      'discountAmount': discountAmount,
      'discountId': discountId,
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
    );
  }

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  @override
  List<Object?> get props {
    return [
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
    ];
  }
}
