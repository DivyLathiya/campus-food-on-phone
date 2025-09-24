import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/order_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/wallet_bloc.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<WalletBloc>().add(LoadWalletBalance(userId: authState.userId));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderPlaced) {
            // Show a success dialog with the unique order ID
            showDialog(
              context: context,
              barrierDismissible: false, // User must tap button to close
              builder: (dialogContext) => AlertDialog(
                title: const Text('Order Placed Successfully!'),
                content: Text(
                    'Your unique order ID is #${state.order.orderId.split('_').last}.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      // Pop all routes until back to the home screen
                      Navigator.of(dialogContext)
                          .popUntil((route) => route.isFirst);
                    },
                  ),
                ],
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
        builder: (context, orderState) {
          if (orderState is! VendorMenuLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return BlocBuilder<WalletBloc, WalletState>(
            builder: (context, walletState) {
              if (walletState is! WalletBalanceLoaded) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Order Summary',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...orderState.cartItems.map(
                                  (item) => ListTile(
                                title: Text(item.menuItem.name),
                                trailing: Text(
                                    '₹${(item.menuItem.price * item.quantity).toStringAsFixed(2)}'),
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              title: const Text(
                                'Total Amount',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                '₹${orderState.totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Wallet Balance',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ListTile(
                              leading: const Icon(Icons.account_balance_wallet),
                              title: const Text('Available Balance'),
                              trailing: Text(
                                '₹${walletState.balance.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Show a loading indicator on the button when placing an order
                    if (orderState is OrderLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      ElevatedButton(
                        onPressed: () {
                          if (walletState.balance >= orderState.totalAmount) {
                            final authState = context.read<AuthBloc>().state;
                            if (authState is AuthAuthenticated) {
                              context.read<OrderBloc>().add(
                                PlaceOrder(
                                  userId: authState.userId,
                                  pickupTime: DateTime.now()
                                      .add(const Duration(minutes: 30)),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Insufficient wallet balance.'),
                                backgroundColor: AppTheme.errorColor,
                              ),
                            );
                          }
                        },
                        child: const Text('Confirm Order'),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}