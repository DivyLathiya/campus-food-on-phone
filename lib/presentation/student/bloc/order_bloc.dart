import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/order_entity.dart';
import 'package:campus_food_app/domain/entities/vendor_entity.dart';
import 'package:campus_food_app/domain/entities/menu_item_entity.dart';
import 'package:campus_food_app/domain/repositories/order_repository.dart';
import 'package:campus_food_app/domain/repositories/vendor_repository.dart';
import 'package:campus_food_app/domain/repositories/menu_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  final VendorRepository vendorRepository;
  final MenuRepository menuRepository;

  OrderBloc({
    required this.orderRepository,
    required this.vendorRepository,
    required this.menuRepository,
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
      if (currentState is VendorMenuLoaded && currentState.cartItems.isNotEmpty) {
        // Convert cart items to order items
        final orderItems = currentState.cartItems.map((cartItem) => OrderItemEntity(
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
          pickupSlot: event.pickupTime,
          createdAt: DateTime.now(),
          specialInstructions: event.specialInstructions,
        );

        final createdOrder = await orderRepository.createOrder(order);

        emit(OrderPlaced(order: createdOrder));
        // Clear cart after successful order
        add(ClearCart());
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
      final order = await orderRepository.updateOrderStatus(
        event.orderId,
        'cancelled',
      );
      emit(OrderCancelled(order: order));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }
}