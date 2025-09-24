import 'package:equatable/equatable.dart';

class OrderItemEntity {
  final String menuItemId;
  final String name;
  final double price;
  final int quantity;
  final String? notes;

  OrderItemEntity({
    required this.menuItemId,
    required this.name,
    required this.price,
    required this.quantity,
    this.notes,
  });

  double get totalPrice => price * quantity;
}

class OrderEntity extends Equatable {
  final String orderId;
  final String studentId;
  final String vendorId;
  final List<OrderItemEntity> items;
  final double totalAmount;
  final String status;
  final DateTime pickupSlot;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? specialInstructions;
  final double? discountAmount;
  final String? discountId;
  final String paymentMethod; // 'wallet' or 'other'

  const OrderEntity({
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
  });

  OrderEntity copyWith({
    String? orderId,
    String? studentId,
    String? vendorId,
    List<OrderItemEntity>? items,
    double? totalAmount,
    String? status,
    DateTime? pickupSlot,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? specialInstructions,
    double? discountAmount,
    String? discountId,
    String? paymentMethod,
  }) {
    return OrderEntity(
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
    );
  }

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

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
      ];
}
