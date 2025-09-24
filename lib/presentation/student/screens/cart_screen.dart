import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/order_bloc.dart';

// Change the class name from MenuScreen to CartScreen
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
                      return ListTile(
                        title: Text(cartItem.menuItem.name),
                        subtitle: Text('₹${cartItem.menuItem.price.toStringAsFixed(2)}'),
                        trailing: Text('Qty: ${cartItem.quantity}'),
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
                  '₹${state.totalAmount.toStringAsFixed(2)}', // Changed from $
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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