part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderEntity> orders;
  final List<OrderEntity> pendingOrders;
  final List<OrderEntity> preparingOrders;
  final List<OrderEntity> readyOrders;

  const OrderLoaded({
    required this.orders,
    required this.pendingOrders,
    required this.preparingOrders,
    required this.readyOrders,
  });

  @override
  List<Object> get props => [orders, pendingOrders, preparingOrders, readyOrders];
}

class OrderOperationSuccess extends OrderState {
  final String message;
  final List<OrderEntity> orders;

  const OrderOperationSuccess({
    required this.message,
    required this.orders,
  });

  @override
  List<Object> get props => [message, orders];
}

class OrderError extends OrderState {
  final String message;

  const OrderError({required this.message});

  @override
  List<Object> get props => [message];
}
