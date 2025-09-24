import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/order_bloc.dart';
import 'package:campus_food_app/domain/entities/vendor_entity.dart';
import 'package:campus_food_app/domain/entities/menu_item_entity.dart';

class MenuScreen extends StatefulWidget {
  final VendorEntity vendor;

  const MenuScreen({super.key, required this.vendor});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(LoadVendorMenu(vendorId: widget.vendor.vendorId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vendor.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/student/cart');
            },
          ),
        ],
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VendorMenuLoaded) {
            return ListView.builder(
              itemCount: state.menuItems.length,
              itemBuilder: (context, index) {
                final menuItem = state.menuItems[index];
                final discountedPrice = menuItem.price * 0.9; // 10% discount
                final hasDiscount = true; // For demo purposes

                return _buildMenuItemCard(context, menuItem, hasDiscount, discountedPrice);
              },
            );
          } else if (state is OrderError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No menu items found.'));
        },
      ),
    );
  }

  Widget _buildMenuItemCard(BuildContext context, MenuItemEntity menuItem, bool hasDiscount, double discountedPrice) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              menuItem.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              menuItem.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(hasDiscount)
                      Text(
                        '₹${menuItem.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey
                        ),
                      ),
                    Text(
                      '₹${(hasDiscount ? discountedPrice : menuItem.price).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<OrderBloc>().add(AddToCart(menuItem: menuItem));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${menuItem.name} added to cart'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
