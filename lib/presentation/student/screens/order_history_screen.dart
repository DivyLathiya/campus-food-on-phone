import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';
import 'package:campus_food_app/domain/entities/order_entity.dart';
import 'package:campus_food_app/presentation/student/bloc/order_bloc.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            // Dispatch the event to load the order history for the logged-in user
            context.read<OrderBloc>().add(LoadOrderHistory(userId: state.userId));
            return BlocBuilder<OrderBloc, OrderState>(
              builder: (context, orderState) {
                if (orderState is OrderLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (orderState is OrderHistoryLoaded) {
                  if (orderState.orders.isEmpty) {
                    return const Center(
                      child: Text('No order history found.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: orderState.orders.length,
                    itemBuilder: (context, index) {
                      final order = orderState.orders[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            'Order #${order.orderId.split('_').last}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'Vendor: ${order.vendorId.replaceAll('_', ' ').split(' ').map((e) => e[0].toUpperCase() + e.substring(1)).join(' ')}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Date: ${DateFormat.yMMMd().format(order.createdAt)}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Total: ₹${order.totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                order.status,
                                style: TextStyle(
                                  color: _getStatusColor(order.status),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(Icons.chevron_right),
                            ],
                          ),
                          onTap: () {
                            // TODO: Navigate to order details screen
                          },
                        ),
                      );
                    },
                  );
                } else if (orderState is OrderError) {
                  return Center(child: Text(orderState.message));
                }
                return const Center(
                  child: Text('Loading your order history...'),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return AppTheme.successColor;
      case 'cancelled':
        return AppTheme.errorColor;
      case 'preparing':
        return AppTheme.warningColor;
      default:
        return Colors.grey;
    }
  }
}