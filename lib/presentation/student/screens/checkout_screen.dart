import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/order_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/wallet_bloc.dart';
import 'package:campus_food_app/presentation/vendor/bloc/enhanced_discount_bloc.dart';
import 'package:campus_food_app/domain/entities/enhanced_discount_entity.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  DateTime? _pickupTime;
  String _selectedPaymentMethod = 'wallet'; // 'wallet' or 'other'

  @override
  void initState() {
    super.initState();
    _pickupTime = DateTime.now().add(const Duration(minutes: 30));
    
    // Load enhanced discounts for the vendor
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        final orderState = context.read<OrderBloc>().state;
        if (orderState is VendorMenuLoaded && orderState.cartItems.isNotEmpty) {
          final vendorId = orderState.cartItems.first.menuItem.vendorId;
          context.read<EnhancedDiscountBloc>().add(LoadEnhancedDiscounts(vendorId: vendorId));
        }
      }
    });
  }

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
          // Calculate dynamic discount
          double discountAmount = 0.0;
          EnhancedDiscountEntity? appliedDiscount;
          
          // Get the best available discount for this vendor
          if (orderState.cartItems.isNotEmpty) {
            final vendorId = orderState.cartItems.first.menuItem.vendorId;
            final discountState = context.read<EnhancedDiscountBloc>().state;
            
            if (discountState is EnhancedDiscountsLoaded) {
              final applicableDiscounts = discountState.discounts.where((discount) => 
                discount.vendorId == vendorId && 
                discount.isValid && 
                discount.isApplicableToPaymentMethod(_selectedPaymentMethod)).toList();
              
              if (applicableDiscounts.isNotEmpty) {
                // Get menu item IDs from cart
                final menuItemIds = orderState.cartItems.map((item) => item.menuItem.menuItemId).toList();
                
                // Find the best discount (highest value)
                appliedDiscount = applicableDiscounts.reduce((current, next) {
                  final currentDiscount = current.calculateDiscount(orderState.totalAmount, menuItemIds);
                  final nextDiscount = next.calculateDiscount(orderState.totalAmount, menuItemIds);
                  return currentDiscount > nextDiscount ? current : next;
                });
                discountAmount = appliedDiscount.calculateDiscount(orderState.totalAmount, menuItemIds);
              }
            }
          }
          
          final discountedTotal = orderState.totalAmount - discountAmount;
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
                            ListTile(
                              title: const Text( 'Subtotal'),
                              trailing: Text('₹${orderState.totalAmount.toStringAsFixed(2)}'),
                            ),
                            if (discountAmount > 0 && appliedDiscount != null) ListTile(
                              title: Text('Discount ${appliedDiscount.type == 'percentage' ? '(${appliedDiscount.value.toStringAsFixed(0)}%)' : appliedDiscount.type == 'wallet_only' ? '(Wallet Only)' : ''}'),
                              subtitle: Text(appliedDiscount.description),
                              trailing: Text('- ₹${discountAmount.toStringAsFixed(2)}', style: const TextStyle(color: AppTheme.successColor)),
                            ) else
                            ListTile(
                              title: const Text('Discount'),
                              trailing: Text(_selectedPaymentMethod == 'wallet' ? 'No wallet discount available' : 'No discount available', style: const TextStyle(color: Colors.grey)),
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
                                '₹${discountedTotal.toStringAsFixed(2)}',
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
                              'Payment Method',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            RadioListTile<String>(
                              title: const Text('Pay with Wallet'),
                              subtitle: Text('Available Balance: ₹${walletState.balance.toStringAsFixed(2)}'),
                              value: 'wallet',
                              groupValue: _selectedPaymentMethod,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPaymentMethod = value!;
                                });
                              },
                            ),
                            RadioListTile<String>(
                              title: const Text('Pay with Other Method'),
                              subtitle: const Text('Credit/Debit Card, UPI, etc.'),
                              value: 'other',
                              groupValue: _selectedPaymentMethod,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPaymentMethod = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                        child: ListTile(
                          title: const Text("Pickup Time"),
                          subtitle: Text(DateFormat.yMMMd().add_jm().format(_pickupTime!)),
                          trailing: const Icon(Icons.edit),
                          onTap: () async {
                            final selectedTime = await Navigator.pushNamed(context, '/student/pickup-slot');
                            if(selectedTime != null){
                              setState(() {
                                _pickupTime = selectedTime as DateTime;
                              });
                            }
                          },
                        )
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
                    if (orderState is OrderLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      ElevatedButton(
                        onPressed: () {
                          if (_selectedPaymentMethod == 'wallet') {
                            if (walletState.balance >= discountedTotal) {
                              final authState = context.read<AuthBloc>().state;
                              if (authState is AuthAuthenticated) {
                                context.read<OrderBloc>().add(
                                  PlaceOrder(
                                    userId: authState.userId,
                                    pickupTime: _pickupTime!,
                                    paymentMethod: _selectedPaymentMethod,
                                  ),
                                );
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Insufficient Balance"),
                                    content: Text(
                                        "You do not have enough funds in your wallet. Required: ₹${discountedTotal.toStringAsFixed(2)}, Available: ₹${walletState.balance.toStringAsFixed(2)}. Please top-up."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pushNamed(context, '/student/wallet');
                                          },
                                          child: const Text("Top-up")),
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("OK")),
                                    ],
                                  ));
                            }
                          } else {
                            // For other payment methods, just place the order
                            final authState = context.read<AuthBloc>().state;
                            if (authState is AuthAuthenticated) {
                              context.read<OrderBloc>().add(
                                PlaceOrder(
                                  userId: authState.userId,
                                  pickupTime: _pickupTime!,
                                ),
                              );
                            }
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
