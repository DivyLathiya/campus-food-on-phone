import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/domain/entities/order_entity.dart';
import 'package:campus_food_app/presentation/student/bloc/order_bloc.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.orderId.split('_').last}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${order.status}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Date: ${DateFormat.yMMMd().format(order.createdAt)}'),
            Text('Pickup Time: ${DateFormat.jm().format(order.pickupSlot)}'),
            const SizedBox(height: 20),
            const Text('Items:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...order.items.map((item) => ListTile(
              title: Text(item.name),
              trailing: Text('x${item.quantity}'),
            )),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Total: ₹${order.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const Spacer(),
            if (order.status == 'pending' || order.status == 'accepted')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    context.read<OrderBloc>().add(CancelOrder(orderId: order.orderId));
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel Order'),
                ),
              ),
            if (order.status == 'completed')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/student/feedback', arguments: order.vendorId);
                  },
                  child: const Text('Leave Feedback'),
                ),
              )
          ],
        ),
      ),
    );
  }
}
