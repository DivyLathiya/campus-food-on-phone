import 'package:campus_food_app/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getUserOrders(String userId);
  Future<List<OrderEntity>> getOrdersByUser(String userId);
  Future<List<OrderEntity>> getOrdersByVendor(String vendorId);
  Future<OrderEntity?> getOrderById(String orderId);
  Future<OrderEntity> createOrder(OrderEntity order);
  Future<OrderEntity> updateOrder(OrderEntity order);
  Future<OrderEntity> updateOrderStatus(String orderId, String status);
  Future<List<OrderEntity>> getAllOrders();
}
