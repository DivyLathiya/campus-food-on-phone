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
  });

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
