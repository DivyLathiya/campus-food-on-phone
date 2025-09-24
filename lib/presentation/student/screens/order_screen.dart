import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/order_bloc.dart';
import 'package:campus_food_app/domain/entities/menu_item_entity.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    // Assuming 'vendor_1' is the default vendor for veg items.
    // In a real app, you might have a vendor selection screen first.
    context.read<OrderBloc>().add(const LoadVendorMenu(vendorId: 'vendor_1'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Vegetarian Food'),
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
            final vegMenuItems = state.menuItems
                .where((item) =>
            item.tags?.contains('vegetarian') ?? false)
                .toList();
            return ListView.builder(
              itemCount: vegMenuItems.length,
              itemBuilder: (context, index) {
                final menuItem = vegMenuItems[index];
                return _buildMenuItemCard(context, menuItem);
              },
            );
          } else if (state is OrderError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No vegetarian menu items found.'));
        },
      ),
    );
  }

  Widget _buildMenuItemCard(BuildContext context, MenuItemEntity menuItem) {
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
                Text(
                  '₹${menuItem.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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