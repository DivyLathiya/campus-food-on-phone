import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:campus_food_app/presentation/vendor/bloc/order_bloc.dart';
import 'package:campus_food_app/domain/entities/order_entity.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<OrderBloc>().add(LoadOrders(vendorId: authState.userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order Management (KDS)'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Preparing'),
              Tab(text: 'Ready'),
            ],
          ),
        ),
        body: BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrderOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            } else if (state is OrderError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppTheme.errorColor,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderLoaded || state is OrderOperationSuccess) {
              List<OrderEntity> pendingOrders = [];
              List<OrderEntity> preparingOrders = [];
              List<OrderEntity> readyOrders = [];

              if (state is OrderLoaded) {
                pendingOrders = state.pendingOrders;
                preparingOrders = state.preparingOrders;
                readyOrders = state.readyOrders;
              } else if (state is OrderOperationSuccess) {
                // For operation success, we need to categorize the orders
                pendingOrders = _filterOrdersByStatus(state.orders, 'pending');
                preparingOrders = _filterOrdersByStatus(state.orders, 'preparing');
                readyOrders = _filterOrdersByStatus(state.orders, 'ready');
              }

              return TabBarView(
                children: [
                  _buildOrderTab(context, pendingOrders, 'pending'),
                  _buildOrderTab(context, preparingOrders, 'preparing'),
                  _buildOrderTab(context, readyOrders, 'ready'),
                ],
              );
            } else if (state is OrderError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        final authState = context.read<AuthBloc>().state;
                        if (authState is AuthAuthenticated) {
                          context.read<OrderBloc>().add(LoadOrders(vendorId: authState.userId));
                        }
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  List<OrderEntity> _filterOrdersByStatus(List<OrderEntity> orders, String status) {
    return orders.where((order) => order.status == status).toList();
  }

  Widget _buildOrderTab(BuildContext context, List<OrderEntity> orders, String status) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              status == 'pending' ? Icons.pending_actions : 
              status == 'preparing' ? Icons.kitchen : 
              Icons.delivery_dining,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No ${status} orders',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(context, order, status);
      },
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderEntity order, String status) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${order.orderId}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDateTime(order.createdAt),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            
            // Pickup Time
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: AppTheme.primaryColor),
                const SizedBox(width: 4),
                Text(
                  'Pickup: ${_formatDateTime(order.pickupSlot)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Order Items
            const Text(
              'Items:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...order.items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${item.quantity}x ${item.name}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Text(
                    '₹${item.totalPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )),
            
            if (order.specialInstructions != null && order.specialInstructions!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info, size: 16, color: Colors.orange),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Note: ${order.specialInstructions}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            const Divider(height: 24),
            
            // Order Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₹${order.totalAmount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            
            if (order.discountAmount != null && order.discountAmount! > 0) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount Applied:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '-₹${order.discountAmount!.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.successColor,
                    ),
                  ),
                ],
              ),
            ],
            
            const SizedBox(height: 16),
            
            // Action Buttons
            _buildActionButtons(context, order, status),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, OrderEntity order, String status) {
    switch (status) {
      case 'pending':
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showRejectOrderDialog(context, order),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Reject'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () => context.read<OrderBloc>().add(AcceptOrder(orderId: order.orderId)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.successColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Accept'),
              ),
            ),
          ],
        );
      case 'preparing':
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => context.read<OrderBloc>().add(MarkOrderReady(orderId: order.orderId)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Mark Ready'),
              ),
            ),
          ],
        );
      case 'ready':
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // Order is ready for pickup, no further action needed
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Order is ready for customer pickup'),
                      backgroundColor: AppTheme.successColor,
                    ),
                  );
                },
                child: const Text('Ready for Pickup'),
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _showRejectOrderDialog(BuildContext context, OrderEntity order) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reject Order'),
        content: const Text(
          'Are you sure you want to reject this order? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<OrderBloc>().add(RejectOrder(orderId: order.orderId));
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy - hh:mm a').format(dateTime);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'preparing':
        return Colors.blue;
      case 'ready':
        return AppTheme.successColor;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
