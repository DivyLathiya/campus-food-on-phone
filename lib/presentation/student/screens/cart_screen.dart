import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/order_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is VendorMenuLoaded && state.cartItems.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = state.cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem.menuItem.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        '₹${cartItem.menuItem.price.toStringAsFixed(2)}'),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      if (cartItem.quantity > 1) {
                                        context.read<OrderBloc>().add(
                                          UpdateCartItemQuantity(
                                            menuItemId: cartItem
                                                .menuItem.menuItemId,
                                            quantity: cartItem.quantity - 1,
                                          ),
                                        );
                                      } else {
                                        context.read<OrderBloc>().add(
                                          RemoveFromCart(
                                              menuItemId: cartItem
                                                  .menuItem.menuItemId),
                                        );
                                      }
                                    },
                                  ),
                                  Text('${cartItem.quantity}'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      context.read<OrderBloc>().add(
                                        UpdateCartItemQuantity(
                                          menuItemId:
                                          cartItem.menuItem.menuItemId,
                                          quantity: cartItem.quantity + 1,
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      context.read<OrderBloc>().add(
                                        RemoveFromCart(
                                            menuItemId:
                                            cartItem.menuItem.menuItemId),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                _buildCartSummary(context, state),
              ],
            );
          } else {
            return const Center(
              child: Text('Your cart is empty.'),
            );
          }
        },
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context, VendorMenuLoaded state) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '₹${state.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to checkout screen
              },
              child: const Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}