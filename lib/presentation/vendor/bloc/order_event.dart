part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends OrderEvent {
  final String vendorId;

  const LoadOrders({required this.vendorId});

  @override
  List<Object> get props => [vendorId];
}

class UpdateOrderStatus extends OrderEvent {
  final String orderId;
  final String status;

  const UpdateOrderStatus({
    required this.orderId,
    required this.status,
  });

  @override
  List<Object> get props => [orderId, status];
}

class AcceptOrder extends OrderEvent {
  final String orderId;

  const AcceptOrder({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class RejectOrder extends OrderEvent {
  final String orderId;

  const RejectOrder({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class MarkOrderPreparing extends OrderEvent {
  final String orderId;

  const MarkOrderPreparing({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class MarkOrderReady extends OrderEvent {
  final String orderId;

  const MarkOrderReady({required this.orderId});

  @override
  List<Object> get props => [orderId];
}
