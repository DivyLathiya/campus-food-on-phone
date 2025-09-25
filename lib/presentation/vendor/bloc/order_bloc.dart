import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/order_entity.dart';
import 'package:campus_food_app/domain/repositories/order_repository.dart';
import 'package:campus_food_app/domain/repositories/user_repository.dart';
import 'package:campus_food_app/domain/repositories/menu_repository.dart';
import 'package:campus_food_app/domain/repositories/notification_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  final UserRepository userRepository;
  final MenuRepository menuRepository;
  final NotificationRepository notificationRepository;

  OrderBloc({
    required this.orderRepository, 
    required this.userRepository,
    required this.menuRepository,
    required this.notificationRepository,
  }) : super(OrderInitial()) {
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
        // Find the order to check stock availability
        final order = currentState.orders.firstWhere(
          (order) => order.orderId == event.orderId,
          orElse: () => throw Exception('Order not found'),
        );
        
        // Check stock availability for all items in the order
        for (final item in order.items) {
          final isAvailable = await menuRepository.checkStockAvailability(
            item.menuItemId,
            item.quantity,
          );
          
          if (!isAvailable) {
            // Get menu item details for better error message
            final menuItem = await menuRepository.getMenuItemById(item.menuItemId);
            final itemName = menuItem?.name ?? item.name;
            
            emit(OrderError(
              message: 'Cannot accept order: "$itemName" is out of stock or insufficient quantity available',
            ));
            return;
          }
        }
        
        // If all items are in stock, proceed with accepting the order
        await orderRepository.updateOrderStatus(event.orderId, 'preparing');
        
        // Update stock quantities for ordered items
        for (final item in order.items) {
          try {
            final menuItem = await menuRepository.getMenuItemById(item.menuItemId);
            if (menuItem != null && menuItem.stockQuantity != null) {
              final newQuantity = menuItem.stockQuantity! - item.quantity;
              await menuRepository.updateStock(item.menuItemId, newQuantity);
            }
          } catch (e) {
            // Log error but continue with order acceptance
            print('Failed to update stock for item ${item.menuItemId}: ${e.toString()}');
          }
        }
        
        // Reload orders to get updated state
        final updatedOrders = await orderRepository.getOrdersByVendor(currentState.orders.first.vendorId);
        final pendingOrders = _filterOrdersByStatus(updatedOrders, 'pending');
        final preparingOrders = _filterOrdersByStatus(updatedOrders, 'preparing');
        final readyOrders = _filterOrdersByStatus(updatedOrders, 'ready');

        emit(OrderOperationSuccess(
          message: 'Order accepted successfully',
          orders: updatedOrders,
        ));
        
        // Send order accepted notification to student
        await notificationRepository.sendOrderStatusNotification(
          order.studentId,
          order.orderId,
          'accepted',
          'Order Accepted',
          'Your order #${order.orderId} has been accepted and is being prepared.',
        );
        
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
        // Find the order to check payment method
        final order = currentState.orders.firstWhere(
          (order) => order.orderId == event.orderId,
          orElse: () => throw Exception('Order not found'),
        );
        
        // Calculate refund amount (always full for vendor rejections)
        final refundAmount = order.totalAmount;
        
        // Process instant refund if paid with wallet
        if (order.paymentMethod == 'wallet') {
          await userRepository.addFundsToWallet(
            order.studentId,
            refundAmount,
            'Full refund for rejected order ${order.orderId}',
          );
        }
        
        // Update order status and rejection details
        final updatedOrder = order.copyWith(
          status: 'rejected',
          cancelledAt: DateTime.now(),
          cancellationReason: event.reason ?? 'Rejected by vendor',
          isRefunded: refundAmount > 0,
          refundedAt: refundAmount > 0 ? DateTime.now() : null,
          refundReason: 'Order rejected by vendor',
        );
        
        await orderRepository.updateOrder(updatedOrder);
        
        // Reload orders to get updated state
        final updatedOrders = await orderRepository.getOrdersByVendor(currentState.orders.first.vendorId);
        final pendingOrders = _filterOrdersByStatus(updatedOrders, 'pending');
        final preparingOrders = _filterOrdersByStatus(updatedOrders, 'preparing');
        final readyOrders = _filterOrdersByStatus(updatedOrders, 'ready');

        String message = 'Order rejected successfully';
        if (order.paymentMethod == 'wallet') {
          message += ' and refund processed';
        }

        // Send order rejected notification to student
        String notificationMessage = 'Your order #${order.orderId} has been rejected by the vendor.';
        if (order.paymentMethod == 'wallet') {
          notificationMessage += ' A refund of ₹${refundAmount.toStringAsFixed(2)} has been processed to your wallet.';
        }
        
        await notificationRepository.sendOrderStatusNotification(
          order.studentId,
          order.orderId,
          'rejected',
          'Order Rejected',
          notificationMessage,
        );
        
        emit(OrderOperationSuccess(
          message: message,
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

        // Find the order to send notification
        final order = currentState.orders.firstWhere(
          (order) => order.orderId == event.orderId,
          orElse: () => throw Exception('Order not found'),
        );
        
        // Send order ready notification to student
        await notificationRepository.sendOrderStatusNotification(
          order.studentId,
          order.orderId,
          'ready',
          'Order Ready for Pickup',
          'Your order #${order.orderId} is ready for pickup! Please collect it at your scheduled time.',
        );
        
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
