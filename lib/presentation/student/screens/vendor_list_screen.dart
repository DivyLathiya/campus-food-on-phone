import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/vendor_bloc.dart';
import 'package:campus_food_app/domain/entities/vendor_entity.dart';

class VendorListScreen extends StatelessWidget {
  const VendorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Food'),
      ),
      body: BlocBuilder<VendorBloc, VendorState>(
        builder: (context, state) {
          if (state is VendorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VendorsLoaded) {
            return ListView.builder(
              itemCount: state.vendors.length,
              itemBuilder: (context, index) {
                final vendor = state.vendors[index];
                return _buildVendorCard(context, vendor);
              },
            );
          } else if (state is VendorError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No vendors found.'));
        },
      ),
    );
  }

  Widget _buildVendorCard(BuildContext context, VendorEntity vendor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/student/menu', arguments: vendor);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vendor.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                vendor.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '${vendor.rating} (${vendor.reviewCount} reviews)',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}