import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';
import 'package:campus_food_app/domain/entities/order_entity.dart';
import 'package:campus_food_app/presentation/student/bloc/order_bloc.dart';

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
            return BlocProvider(
              create: (context) =>
              OrderBloc(
                orderRepository: context.read(),
                vendorRepository: context.read(),
                menuRepository: context.read(),
              )
                ..add(LoadOrderHistory(userId: state.userId)),
              child: BlocBuilder<OrderBloc, OrderState>(
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
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text('Order #${order.orderId}'),
                            subtitle: Text('Total: ₹${order.totalAmount
                                .toStringAsFixed(2)}'),
                            trailing: Text(order.status),
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
                    child: Text('Something went wrong.'),
                  );
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}