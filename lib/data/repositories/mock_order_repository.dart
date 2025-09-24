import 'package:campus_food_app/data/datasources/mock_data_source.dart';
import 'package:campus_food_app/data/models/order_model.dart';
import 'package:campus_food_app/domain/entities/order_entity.dart';
import 'package:campus_food_app/domain/repositories/order_repository.dart';

class MockOrderRepository implements OrderRepository {
  @override
  Future<List<OrderEntity>> getUserOrders(String userId) async {
    return getOrdersByUser(userId);
  }

  @override
  Future<List<OrderEntity>> getOrdersByUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final orders = MockDataSource.getOrdersByUser(userId);
    return orders.map((order) => OrderEntity(
      orderId: order.orderId,
      studentId: order.studentId,
      vendorId: order.vendorId,
      items: order.items.map((item) => OrderItemEntity(
        menuItemId: item.menuItemId,
        name: item.name,
        price: item.price,
        quantity: item.quantity,
        notes: item.notes,
      )).toList(),
      totalAmount: order.totalAmount,
      status: order.status,
      pickupSlot: order.pickupSlot,
      createdAt: order.createdAt,
      updatedAt: order.updatedAt,
      specialInstructions: order.specialInstructions,
      discountAmount: order.discountAmount,
      discountId: order.discountId,
    )).toList();
  }

  @override
  Future<List<OrderEntity>> getOrdersByVendor(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final orders = MockDataSource.getOrdersByVendor(vendorId);
    return orders.map((order) => OrderEntity(
      orderId: order.orderId,
      studentId: order.studentId,
      vendorId: order.vendorId,
      items: order.items.map((item) => OrderItemEntity(
        menuItemId: item.menuItemId,
        name: item.name,
        price: item.price,
        quantity: item.quantity,
        notes: item.notes,
      )).toList(),
      totalAmount: order.totalAmount,
      status: order.status,
      pickupSlot: order.pickupSlot,
      createdAt: order.createdAt,
      updatedAt: order.updatedAt,
      specialInstructions: order.specialInstructions,
      discountAmount: order.discountAmount,
      discountId: order.discountId,
    )).toList();
  }

  @override
  Future<OrderEntity?> getOrderById(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      final order = MockDataSource.orders.firstWhere((o) => o.orderId == orderId);
      return OrderEntity(
        orderId: order.orderId,
        studentId: order.studentId,
        vendorId: order.vendorId,
        items: order.items.map((item) => OrderItemEntity(
          menuItemId: item.menuItemId,
          name: item.name,
          price: item.price,
          quantity: item.quantity,
          notes: item.notes,
        )).toList(),
        totalAmount: order.totalAmount,
        status: order.status,
        pickupSlot: order.pickupSlot,
        createdAt: order.createdAt,
        updatedAt: order.updatedAt,
        specialInstructions: order.specialInstructions,
        discountAmount: order.discountAmount,
        discountId: order.discountId,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<OrderEntity> createOrder(OrderEntity order) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final newOrder = OrderModel(
      orderId: 'order_${MockDataSource.orders.length + 1}',
      studentId: order.studentId,
      vendorId: order.vendorId,
      items: order.items.map((item) => OrderItemModel(
        menuItemId: item.menuItemId,
        name: item.name,
        price: item.price,
        quantity: item.quantity,
        notes: item.notes,
      )).toList(),
      totalAmount: order.totalAmount,
      status: order.status,
      pickupSlot: order.pickupSlot,
      createdAt: order.createdAt,
      updatedAt: order.updatedAt,
      specialInstructions: order.specialInstructions,
      discountAmount: order.discountAmount,
      discountId: order.discountId,
    );
    
    MockDataSource.orders.add(newOrder);
    
    return OrderEntity(
      orderId: newOrder.orderId,
      studentId: newOrder.studentId,
      vendorId: newOrder.vendorId,
      items: newOrder.items.map((item) => OrderItemEntity(
        menuItemId: item.menuItemId,
        name: item.name,
        price: item.price,
        quantity: item.quantity,
        notes: item.notes,
      )).toList(),
      totalAmount: newOrder.totalAmount,
      status: newOrder.status,
      pickupSlot: newOrder.pickupSlot,
      createdAt: newOrder.createdAt,
      updatedAt: newOrder.updatedAt,
      specialInstructions: newOrder.specialInstructions,
      discountAmount: newOrder.discountAmount,
      discountId: newOrder.discountId,
    );
  }

  @override
  Future<OrderEntity> updateOrder(OrderEntity order) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.orders.indexWhere((o) => o.orderId == order.orderId);
    if (index != -1) {
      final updatedOrder = MockDataSource.orders[index].copyWith(
        status: order.status,
        pickupSlot: order.pickupSlot,
        updatedAt: DateTime.now(),
        specialInstructions: order.specialInstructions,
        discountAmount: order.discountAmount,
        discountId: order.discountId,
      );
      
      MockDataSource.orders[index] = updatedOrder;
      
      return OrderEntity(
        orderId: updatedOrder.orderId,
        studentId: updatedOrder.studentId,
        vendorId: updatedOrder.vendorId,
        items: updatedOrder.items.map((item) => OrderItemEntity(
          menuItemId: item.menuItemId,
          name: item.name,
          price: item.price,
          quantity: item.quantity,
          notes: item.notes,
        )).toList(),
        totalAmount: updatedOrder.totalAmount,
        status: updatedOrder.status,
        pickupSlot: updatedOrder.pickupSlot,
        createdAt: updatedOrder.createdAt,
        updatedAt: updatedOrder.updatedAt,
        specialInstructions: updatedOrder.specialInstructions,
        discountAmount: updatedOrder.discountAmount,
        discountId: updatedOrder.discountId,
      );
    }
    
    throw Exception('Order not found');
  }

  @override
  Future<List<OrderEntity>> getAllOrders() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return MockDataSource.orders.map((order) => OrderEntity(
      orderId: order.orderId,
      studentId: order.studentId,
      vendorId: order.vendorId,
      items: order.items.map((item) => OrderItemEntity(
        menuItemId: item.menuItemId,
        name: item.name,
        price: item.price,
        quantity: item.quantity,
        notes: item.notes,
      )).toList(),
      totalAmount: order.totalAmount,
      status: order.status,
      pickupSlot: order.pickupSlot,
      createdAt: order.createdAt,
      updatedAt: order.updatedAt,
      specialInstructions: order.specialInstructions,
      discountAmount: order.discountAmount,
      discountId: order.discountId,
    )).toList();
  }

  @override
  Future<OrderEntity> updateOrderStatus(String orderId, String status) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.orders.indexWhere((o) => o.orderId == orderId);
    if (index != -1) {
      final updatedOrder = MockDataSource.orders[index].copyWith(
        status: status,
        updatedAt: DateTime.now(),
      );
      
      MockDataSource.orders[index] = updatedOrder;
      
      return OrderEntity(
        orderId: updatedOrder.orderId,
        studentId: updatedOrder.studentId,
        vendorId: updatedOrder.vendorId,
        items: updatedOrder.items.map((item) => OrderItemEntity(
          menuItemId: item.menuItemId,
          name: item.name,
          price: item.price,
          quantity: item.quantity,
          notes: item.notes,
        )).toList(),
        totalAmount: updatedOrder.totalAmount,
        status: updatedOrder.status,
        pickupSlot: updatedOrder.pickupSlot,
        createdAt: updatedOrder.createdAt,
        updatedAt: updatedOrder.updatedAt,
        specialInstructions: updatedOrder.specialInstructions,
        discountAmount: updatedOrder.discountAmount,
        discountId: updatedOrder.discountId,
      );
    }
    
    throw Exception('Order not found');
  }
}
