part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadVendors extends OrderEvent {
  const LoadVendors();
}

class LoadVendorMenu extends OrderEvent {
  final String vendorId;

  const LoadVendorMenu({required this.vendorId});

  @override
  List<Object> get props => [vendorId];
}

class AddToCart extends OrderEvent {
  final MenuItemEntity menuItem;

  const AddToCart({required this.menuItem});

  @override
  List<Object> get props => [menuItem];
}

class RemoveFromCart extends OrderEvent {
  final String menuItemId;

  const RemoveFromCart({required this.menuItemId});

  @override
  List<Object> get props => [menuItemId];
}

class UpdateCartItemQuantity extends OrderEvent {
  final String menuItemId;
  final int quantity;

  const UpdateCartItemQuantity({
    required this.menuItemId,
    required this.quantity,
  });

  @override
  List<Object> get props => [menuItemId, quantity];
}

class ClearCart extends OrderEvent {
  const ClearCart();
}

class PlaceOrder extends OrderEvent {
  final String userId;
  final DateTime pickupTime;
  final String? specialInstructions;
  final String paymentMethod;

  const PlaceOrder({
    required this.userId,
    required this.pickupTime,
    this.specialInstructions,
    this.paymentMethod = 'other',
  });

  @override
  List<Object> get props => [userId, pickupTime, specialInstructions ?? '', paymentMethod];
}

class LoadOrderHistory extends OrderEvent {
  final String userId;

  const LoadOrderHistory({required this.userId});

  @override
  List<Object> get props => [userId];
}

class GetOrderDetails extends OrderEvent {
  final String orderId;

  const GetOrderDetails({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class CancelOrder extends OrderEvent {
  final String orderId;
  final String? cancellationReason;

  const CancelOrder({
    required this.orderId,
    this.cancellationReason,
  });

  @override
  List<Object> get props => [orderId, cancellationReason ?? ''];
}
