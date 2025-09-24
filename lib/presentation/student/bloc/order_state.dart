part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrderError extends OrderState {
  final String message;

  const OrderError({required this.message});

  @override
  List<Object> get props => [message];
}

class VendorsLoaded extends OrderState {
  final List<VendorEntity> vendors;

  const VendorsLoaded({required this.vendors});

  @override
  List<Object> get props => [vendors];
}

class VendorMenuLoaded extends OrderState {
  final String vendorId;
  final List<MenuItemEntity> menuItems;
  final List<CartItem> cartItems;

  const VendorMenuLoaded({
    required this.vendorId,
    required this.menuItems,
    this.cartItems = const [],
  });

  VendorMenuLoaded copyWith({
    String? vendorId,
    List<MenuItemEntity>? menuItems,
    List<CartItem>? cartItems,
  }) {
    return VendorMenuLoaded(
      vendorId: vendorId ?? this.vendorId,
      menuItems: menuItems ?? this.menuItems,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  double get totalAmount {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item.menuItem.price * item.quantity),
    );
  }

  @override
  List<Object> get props => [vendorId, menuItems, cartItems];
}

class OrderPlaced extends OrderState {
  final OrderEntity order;

  const OrderPlaced({required this.order});

  @override
  List<Object> get props => [order];
}

class OrderHistoryLoaded extends OrderState {
  final List<OrderEntity> orders;

  const OrderHistoryLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class OrderDetailsLoaded extends OrderState {
  final OrderEntity order;

  const OrderDetailsLoaded({required this.order});

  @override
  List<Object> get props => [order];
}

class OrderCancelled extends OrderState {
  final OrderEntity order;
  final String? message;

  const OrderCancelled({
    required this.order,
    this.message,
  });

  @override
  List<Object> get props => [order, message ?? ''];
}

class CartItem extends Equatable {
  final MenuItemEntity menuItem;
  final int quantity;

  const CartItem({
    required this.menuItem,
    required this.quantity,
  });

  CartItem copyWith({
    MenuItemEntity? menuItem,
    int? quantity,
  }) {
    return CartItem(
      menuItem: menuItem ?? this.menuItem,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => menuItem.price * quantity;

  @override
  List<Object> get props => [menuItem, quantity];
}
