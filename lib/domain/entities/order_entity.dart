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
  final DateTime? cancelledAt;
  final String? cancellationReason;
  final bool isRefunded;
  final DateTime? refundedAt;
  final String? refundReason;

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
    this.cancelledAt,
    this.cancellationReason,
    this.isRefunded = false,
    this.refundedAt,
    this.refundReason,
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
    DateTime? cancelledAt,
    String? cancellationReason,
    bool? isRefunded,
    DateTime? refundedAt,
    String? refundReason,
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
      cancelledAt: cancelledAt ?? this.cancelledAt,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      isRefunded: isRefunded ?? this.isRefunded,
      refundedAt: refundedAt ?? this.refundedAt,
      refundReason: refundReason ?? this.refundReason,
    );
  }

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
  
  // Check if order can be cancelled (within 30 minutes of placement and before pickup time)
  bool get canBeCancelled {
    if (status == 'cancelled' || status == 'rejected' || status == 'completed') {
      return false;
    }
    
    final now = DateTime.now();
    final timeSinceOrder = now.difference(createdAt);
    final timeUntilPickup = pickupSlot.difference(now);
    
    // Can cancel within 30 minutes of placing order
    // And must be at least 15 minutes before pickup time
    return timeSinceOrder.inMinutes <= 30 && timeUntilPickup.inMinutes >= 15;
  }
  
  // Get cancellation time limit
  DateTime get cancellationDeadline {
    final thirtyMinutesAfterOrder = createdAt.add(const Duration(minutes: 30));
    final fifteenMinutesBeforePickup = pickupSlot.subtract(const Duration(minutes: 15));
    
    // The earlier of the two limits
    return thirtyMinutesAfterOrder.isBefore(fifteenMinutesBeforePickup) 
        ? thirtyMinutesAfterOrder 
        : fifteenMinutesBeforePickup;
  }
  
  // Get time remaining for cancellation
  Duration get cancellationTimeRemaining {
    final deadline = cancellationDeadline;
    final now = DateTime.now();
    
    if (now.isAfter(deadline)) {
      return Duration.zero;
    }
    
    return deadline.difference(now);
  }
  
  // Get cancellation status message
  String get cancellationStatusMessage {
    if (status == 'cancelled') {
      return 'Order cancelled';
    }
    
    if (status == 'rejected') {
      return 'Order rejected by vendor';
    }
    
    if (!canBeCancelled) {
      if (DateTime.now().difference(createdAt).inMinutes > 30) {
        return 'Cancellation period expired (30-minute limit)';
      } else if (pickupSlot.difference(DateTime.now()).inMinutes < 15) {
        return 'Too close to pickup time (15-minute minimum)';
      }
      return 'Order cannot be cancelled';
    }
    
    final remaining = cancellationTimeRemaining;
    if (remaining.inHours > 0) {
      return 'Can cancel within ${remaining.inHours}h ${remaining.inMinutes % 60}m';
    } else {
      return 'Can cancel within ${remaining.inMinutes}m';
    }
  }
  
  // Check if order is eligible for refund
  bool get isEligibleForRefund {
    return (status == 'cancelled' || status == 'rejected') && !isRefunded;
  }
  
  // Get refund amount (could be partial based on timing)
  double get refundAmount {
    if (!isEligibleForRefund) return 0.0;
    
    // Full refund if cancelled within 15 minutes or rejected by vendor
    final timeSinceOrder = DateTime.now().difference(createdAt);
    if (timeSinceOrder.inMinutes <= 15 || status == 'rejected') {
      return totalAmount;
    }
    
    // Partial refund (80%) if cancelled within 30 minutes
    if (timeSinceOrder.inMinutes <= 30) {
      return totalAmount * 0.8;
    }
    
    return 0.0;
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
