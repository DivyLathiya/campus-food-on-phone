import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/order_entity.dart';
import 'package:campus_food_app/domain/repositories/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<LoadOrders>(_onLoadOrders);
    on<UpdateOrderStatus>(_onUpdateOrderStatus);
    on<AcceptOrder>(_onAcceptOrder);
    on<RejectOrder>(_onRejectOrder);
    on<MarkOrderPreparing>(_onMarkOrderPreparing);
    on<MarkOrderReady>(_onMarkOrderReady);
  }

  List<OrderEntity> _filterOrdersByStatus(List<OrderEntity> orders, String status) {
    return orders.where((order) => order.status == status).toList();
  }

  Future<void> _onLoadOrders(
    LoadOrders event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    try {
      final orders = await orderRepository.getOrdersByVendor(event.vendorId);
      final pendingOrders = _filterOrdersByStatus(orders, 'pending');
      final preparingOrders = _filterOrdersByStatus(orders, 'preparing');
      final readyOrders = _filterOrdersByStatus(orders, 'ready');

      emit(OrderLoaded(
        orders: orders,
        pendingOrders: pendingOrders,
        preparingOrders: preparingOrders,
        readyOrders: readyOrders,
      ));
    } catch (e) {
      emit(OrderError(message: 'Failed to load orders: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateOrderStatus(
    UpdateOrderStatus event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is OrderLoaded) {
        await orderRepository.updateOrderStatus(event.orderId, event.status);
        
        // Reload orders to get updated state
        final updatedOrders = await orderRepository.getOrdersByVendor(currentState.orders.first.vendorId);
        final pendingOrders = _filterOrdersByStatus(updatedOrders, 'pending');
        final preparingOrders = _filterOrdersByStatus(updatedOrders, 'preparing');
        final readyOrders = _filterOrdersByStatus(updatedOrders, 'ready');

        emit(OrderOperationSuccess(
          message: 'Order status updated successfully',
          orders: updatedOrders,
        ));
        
        // Transition back to loaded state with updated orders
        emit(OrderLoaded(
          orders: updatedOrders,
          pendingOrders: pendingOrders,
          preparingOrders: preparingOrders,
          readyOrders: readyOrders,
        ));
      }
    } catch (e) {
      emit(OrderError(message: 'Failed to update order status: ${e.toString()}'));
    }
  }

  Future<void> _onAcceptOrder(
    AcceptOrder event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is OrderLoaded) {
        await orderRepository.updateOrderStatus(event.orderId, 'preparing');
        
        // Reload orders to get updated state
        final updatedOrders = await orderRepository.getOrdersByVendor(currentState.orders.first.vendorId);
        final pendingOrders = _filterOrdersByStatus(updatedOrders, 'pending');
        final preparingOrders = _filterOrdersByStatus(updatedOrders, 'preparing');
        final readyOrders = _filterOrdersByStatus(updatedOrders, 'ready');

        emit(OrderOperationSuccess(
          message: 'Order accepted successfully',
          orders: updatedOrders,
        ));
        
        // Transition back to loaded state with updated orders
        emit(OrderLoaded(
          orders: updatedOrders,
          pendingOrders: pendingOrders,
          preparingOrders: preparingOrders,
          readyOrders: readyOrders,
        ));
      }
    } catch (e) {
      emit(OrderError(message: 'Failed to accept order: ${e.toString()}'));
    }
  }

  Future<void> _onRejectOrder(
    RejectOrder event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is OrderLoaded) {
        await orderRepository.updateOrderStatus(event.orderId, 'rejected');
        
        // Reload orders to get updated state
        final updatedOrders = await orderRepository.getOrdersByVendor(currentState.orders.first.vendorId);
        final pendingOrders = _filterOrdersByStatus(updatedOrders, 'pending');
        final preparingOrders = _filterOrdersByStatus(updatedOrders, 'preparing');
        final readyOrders = _filterOrdersByStatus(updatedOrders, 'ready');

        emit(OrderOperationSuccess(
          message: 'Order rejected successfully',
          orders: updatedOrders,
        ));
        
        // Transition back to loaded state with updated orders
        emit(OrderLoaded(
          orders: updatedOrders,
          pendingOrders: pendingOrders,
          preparingOrders: preparingOrders,
          readyOrders: readyOrders,
        ));
      }
    } catch (e) {
      emit(OrderError(message: 'Failed to reject order: ${e.toString()}'));
    }
  }

  Future<void> _onMarkOrderPreparing(
    MarkOrderPreparing event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is OrderLoaded) {
        await orderRepository.updateOrderStatus(event.orderId, 'preparing');
        
        // Reload orders to get updated state
        final updatedOrders = await orderRepository.getOrdersByVendor(currentState.orders.first.vendorId);
        final pendingOrders = _filterOrdersByStatus(updatedOrders, 'pending');
        final preparingOrders = _filterOrdersByStatus(updatedOrders, 'preparing');
        final readyOrders = _filterOrdersByStatus(updatedOrders, 'ready');

        emit(OrderOperationSuccess(
          message: 'Order marked as preparing',
          orders: updatedOrders,
        ));
        
        // Transition back to loaded state with updated orders
        emit(OrderLoaded(
          orders: updatedOrders,
          pendingOrders: pendingOrders,
          preparingOrders: preparingOrders,
          readyOrders: readyOrders,
        ));
      }
    } catch (e) {
      emit(OrderError(message: 'Failed to mark order as preparing: ${e.toString()}'));
    }
  }

  Future<void> _onMarkOrderReady(
    MarkOrderReady event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is OrderLoaded) {
        await orderRepository.updateOrderStatus(event.orderId, 'ready');
        
        // Reload orders to get updated state
        final updatedOrders = await orderRepository.getOrdersByVendor(currentState.orders.first.vendorId);
        final pendingOrders = _filterOrdersByStatus(updatedOrders, 'pending');
        final preparingOrders = _filterOrdersByStatus(updatedOrders, 'preparing');
        final readyOrders = _filterOrdersByStatus(updatedOrders, 'ready');

        emit(OrderOperationSuccess(
          message: 'Order marked as ready for pickup',
          orders: updatedOrders,
        ));
        
        // Transition back to loaded state with updated orders
        emit(OrderLoaded(
          orders: updatedOrders,
          pendingOrders: pendingOrders,
          preparingOrders: preparingOrders,
          readyOrders: readyOrders,
        ));
      }
    } catch (e) {
      emit(OrderError(message: 'Failed to mark order as ready: ${e.toString()}'));
    }
  }
}
