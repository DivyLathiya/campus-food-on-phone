import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/order_entity.dart';
import 'package:campus_food_app/domain/entities/vendor_entity.dart';
import 'package:campus_food_app/domain/entities/menu_item_entity.dart';
import 'package:campus_food_app/domain/repositories/order_repository.dart';
import 'package:campus_food_app/domain/repositories/vendor_repository.dart';
import 'package:campus_food_app/domain/repositories/menu_repository.dart';
import 'package:campus_food_app/domain/repositories/user_repository.dart';
import 'package:campus_food_app/domain/repositories/pickup_slot_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  final VendorRepository vendorRepository;
  final MenuRepository menuRepository;
  final UserRepository userRepository;
  final PickupSlotRepository pickupSlotRepository;

  OrderBloc({
    required this.orderRepository,
    required this.vendorRepository,
    required this.menuRepository,
    required this.userRepository,
    required this.pickupSlotRepository,
  }) : super(const OrderInitial()) {
    on<LoadVendors>(_onLoadVendors);
    on<LoadVendorMenu>(_onLoadVendorMenu);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
    on<ClearCart>(_onClearCart);
    on<PlaceOrder>(_onPlaceOrder);
    on<LoadOrderHistory>(_onLoadOrderHistory);
    on<GetOrderDetails>(_onGetOrderDetails);
    on<CancelOrder>(_onCancelOrder);
  }

  Future<void> _onLoadVendors(
      LoadVendors event,
      Emitter<OrderState> emit,
      ) async {
    emit(const OrderLoading());
    try {
      final vendors = await vendorRepository.getVendors();
      emit(VendorsLoaded(vendors: vendors));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  Future<void> _onLoadVendorMenu(
      LoadVendorMenu event,
      Emitter<OrderState> emit,
      ) async {
    final currentState = state;
    List<CartItem> currentCartItems = [];
    if (currentState is VendorMenuLoaded) {
      currentCartItems = currentState.cartItems;
    }

    emit(const OrderLoading());
    try {
      final menuItems = await menuRepository.getMenuItems(event.vendorId);
      emit(VendorMenuLoaded(
        vendorId: event.vendorId,
        menuItems: menuItems,
        cartItems: currentCartItems, // Preserve the existing cart items
      ));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  Future<void> _onAddToCart(
      AddToCart event,
      Emitter<OrderState> emit,
      ) async {
    try {
      final currentState = state;
      if (currentState is VendorMenuLoaded) {
        final updatedCart = List<CartItem>.from(currentState.cartItems);
        final existingItemIndex = updatedCart.indexWhere(
              (item) => item.menuItem.menuItemId == event.menuItem.menuItemId,
        );

        if (existingItemIndex != -1) {
          updatedCart[existingItemIndex] = updatedCart[existingItemIndex].copyWith(
            quantity: updatedCart[existingItemIndex].quantity + 1,
          );
        } else {
          updatedCart.add(CartItem(menuItem: event.menuItem, quantity: 1));
        }

        emit(currentState.copyWith(cartItems: updatedCart));
      }
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCart event,
      Emitter<OrderState> emit,
      ) async {
    try {
      final currentState = state;
      if (currentState is VendorMenuLoaded) {
        final updatedCart = currentState.cartItems
            .where((item) => item.menuItem.menuItemId != event.menuItemId)
            .toList();
        emit(currentState.copyWith(cartItems: updatedCart));
      }
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  Future<void> _onUpdateCartItemQuantity(
      UpdateCartItemQuantity event,
      Emitter<OrderState> emit,
      ) async {
    try {
      final currentState = state;
      if (currentState is VendorMenuLoaded) {
        final updatedCart = List<CartItem>.from(currentState.cartItems);
        final itemIndex = updatedCart.indexWhere(
              (item) => item.menuItem.menuItemId == event.menuItemId,
        );

        if (itemIndex != -1 && event.quantity > 0) {
          updatedCart[itemIndex] = updatedCart[itemIndex].copyWith(
            quantity: event.quantity,
          );
          emit(currentState.copyWith(cartItems: updatedCart));
        } else if (event.quantity == 0) {
          add(RemoveFromCart(menuItemId: event.menuItemId));
        }
      }
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  Future<void> _onClearCart(
      ClearCart event,
      Emitter<OrderState> emit,
      ) async {
    try {
      final currentState = state;
      if (currentState is VendorMenuLoaded) {
        emit(currentState.copyWith(cartItems: []));
      }
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  Future<void> _onPlaceOrder(
      PlaceOrder event,
      Emitter<OrderState> emit,
      ) async {
    emit(const OrderLoading());
    try {
      final currentState = state;
      if (currentState is VendorMenuLoaded &&
          currentState.cartItems.isNotEmpty) {
        final user = await userRepository.getUserById(event.userId);
        bool canPlaceOrder = false;
        
        if (event.paymentMethod == 'wallet') {
          if (user != null && user.walletBalance >= currentState.totalAmount) {
            await userRepository.withdrawFromWallet(
              event.userId,
              currentState.totalAmount,
              'Order Payment',
            );
            canPlaceOrder = true;
          }
        } else {
          // For other payment methods, assume payment is successful
          canPlaceOrder = true;
        }
        
        if (canPlaceOrder) {
          // Find the best slot for the order
          final optimalSlots = await pickupSlotRepository.getOptimalSlotsForOrder(
            currentState.vendorId,
            event.pickupTime,
            currentState.cartItems.fold(0, (sum, item) => sum + item.quantity),
          );
          
          if (optimalSlots.isEmpty) {
            emit(const OrderError(
              message: 'No available pickup slots for the selected time. Please choose a different time.'
            ));
            return;
          }
          
          // Use the first optimal slot
          final selectedSlot = optimalSlots.first;
          
          // Check if slot has capacity
          if (!selectedSlot.canAcceptMoreOrders) {
            // Add to queue if slot is full
            final queueSuccess = await pickupSlotRepository.addToQueue(
              selectedSlot.slotId,
              'temp_order_${DateTime.now().millisecondsSinceEpoch}',
            );
            
            if (!queueSuccess) {
              emit(const OrderError(
                message: 'Selected pickup slot is full and queue is unavailable. Please choose a different time.'
              ));
              return;
            }
          }
          
          // Book the slot
          final bookingSuccess = await pickupSlotRepository.bookSlot(selectedSlot.slotId);
          if (!bookingSuccess) {
            emit(const OrderError(
              message: 'Failed to book pickup slot. Please try again.'
            ));
            return;
          }

          // Convert cart items to order items
          final orderItems =
          currentState.cartItems.map((cartItem) => OrderItemEntity(
            menuItemId: cartItem.menuItem.menuItemId,
            name: cartItem.menuItem.name,
            price: cartItem.menuItem.price,
            quantity: cartItem.quantity,
          )).toList();

          final totalAmount = currentState.totalAmount;

          final order = OrderEntity(
            orderId: 'order_${DateTime.now().millisecondsSinceEpoch}',
            studentId: event.userId,
            vendorId: currentState.vendorId,
            items: orderItems,
            totalAmount: totalAmount,
            status: 'pending',
            pickupSlot: selectedSlot.startTime,
            createdAt: DateTime.now(),
            specialInstructions: event.specialInstructions,
            paymentMethod: event.paymentMethod,
          );

          final createdOrder = await orderRepository.createOrder(order);

          emit(OrderPlaced(order: createdOrder));
          // Clear cart after successful order
          add(const ClearCart());
        } else {
          emit(const OrderError(message: 'Insufficient wallet balance'));
        }
      } else {
        emit(const OrderError(message: 'Cart is empty'));
      }
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }


  Future<void> _onLoadOrderHistory(
      LoadOrderHistory event,
      Emitter<OrderState> emit,
      ) async {
    emit(const OrderLoading());
    try {
      final orders = await orderRepository.getUserOrders(event.userId);
      emit(OrderHistoryLoaded(orders: orders));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  Future<void> _onGetOrderDetails(
      GetOrderDetails event,
      Emitter<OrderState> emit,
      ) async {
    emit(const OrderLoading());
    try {
      final order = await orderRepository.getOrderById(event.orderId);
      if (order != null) {
        emit(OrderDetailsLoaded(order: order));
      } else {
        emit(const OrderError(message: 'Order not found'));
      }
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  Future<void> _onCancelOrder(
      CancelOrder event,
      Emitter<OrderState> emit,
      ) async {
    emit(const OrderLoading());
    try {
      // First get the order details to check cancellation eligibility
      final order = await orderRepository.getOrderById(event.orderId);
      if (order == null) {
        emit(const OrderError(message: 'Order not found'));
        return;
      }
      
      // Check if order can be cancelled
      if (!order.canBeCancelled) {
        emit(OrderError(message: order.cancellationStatusMessage));
        return;
      }
      
      // Calculate refund amount
      final refundAmount = order.refundAmount;
      
      // Process refund if applicable
      if (refundAmount > 0 && order.paymentMethod == 'wallet') {
        await userRepository.addFundsToWallet(
          order.studentId,
          refundAmount,
          'Refund for cancelled order ${order.orderId}${refundAmount < order.totalAmount ? ' (partial refund)' : ''}',
        );
      }
      
      // Update order status and cancellation details
      final updatedOrder = order.copyWith(
        status: 'cancelled',
        cancelledAt: DateTime.now(),
        cancellationReason: event.cancellationReason,
        isRefunded: refundAmount > 0,
        refundedAt: refundAmount > 0 ? DateTime.now() : null,
        refundReason: refundAmount > 0 ? 'Order cancelled by student' : null,
      );
      
      // Save the updated order
      await orderRepository.updateOrder(updatedOrder);
      
      String message = 'Order cancelled successfully';
      if (refundAmount > 0) {
        if (order.paymentMethod == 'wallet') {
          if (refundAmount == order.totalAmount) {
            message += ' and full refund processed to wallet';
          } else {
            message += ' and partial refund (${(refundAmount / order.totalAmount * 100).round()}%) processed to wallet';
          }
        } else {
          message += ' (refund available for non-wallet payments - contact support)';
        }
      }
      
      emit(OrderCancelled(order: updatedOrder, message: message));
    } catch (e) {
      emit(OrderError(message: 'Failed to cancel order: ${e.toString()}'));
    }
  }
}