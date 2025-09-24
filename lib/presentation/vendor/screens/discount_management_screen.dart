import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:campus_food_app/presentation/vendor/bloc/discount_bloc.dart';
import 'package:campus_food_app/domain/entities/discount_entity.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';
import 'package:campus_food_app/core/utils/app_constants.dart';
import 'package:intl/intl.dart';

class DiscountManagementScreen extends StatefulWidget {
  const DiscountManagementScreen({super.key});

  @override
  _DiscountManagementScreenState createState() => _DiscountManagementScreenState();
}

class _DiscountManagementScreenState extends State<DiscountManagementScreen> {
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<DiscountBloc>().add(LoadDiscounts(vendorId: authState.userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discount Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDiscountDialog(context),
          ),
        ],
      ),
      body: BlocConsumer<DiscountBloc, DiscountState>(
        listener: (context, state) {
          if (state is DiscountOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.successColor,
              ),
            );
          } else if (state is DiscountError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DiscountLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DiscountLoaded) {
            if (state.discounts.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_offer, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No discounts available',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tap the + button to create your first discount',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.discounts.length,
              itemBuilder: (context, index) {
                final discount = state.discounts[index];
                return _buildDiscountCard(context, discount);
              },
            );
          } else if (state is DiscountError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final authState = context.read<AuthBloc>().state;
                      if (authState is AuthAuthenticated) {
                        context.read<DiscountBloc>().add(LoadDiscounts(vendorId: authState.userId));
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildDiscountCard(BuildContext context, DiscountEntity discount) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    discount.description,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: discount.isActive ? AppTheme.successColor : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    discount.isActive ? 'Active' : 'Inactive',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  discount.type == AppConstants.discountPercentage 
                      ? Icons.percent 
                      : Icons.currency_rupee,
                  size: 16,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  discount.type == AppConstants.discountPercentage
                      ? '${discount.value.toStringAsFixed(0)}% off'
                      : '₹${discount.value.toStringAsFixed(0)} off',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if (discount.minOrderAmount != null) ...[
              const SizedBox(height: 4),
              Text(
                'Minimum order: ₹${discount.minOrderAmount!.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
            if (discount.startDate != null || discount.endDate != null) ...[
              const SizedBox(height: 4),
              Text(
                _formatDateRange(discount.startDate, discount.endDate),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _showToggleStatusDialog(context, discount),
                  child: Text(
                    discount.isActive ? 'Deactivate' : 'Activate',
                    style: TextStyle(
                      color: discount.isActive ? Colors.orange : AppTheme.successColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => _showEditDiscountDialog(context, discount),
                  child: const Text('Edit'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => _showDeleteDiscountDialog(context, discount),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateRange(DateTime? startDate, DateTime? endDate) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    if (startDate != null && endDate != null) {
      return '${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}';
    } else if (startDate != null) {
      return 'From ${dateFormat.format(startDate)}';
    } else if (endDate != null) {
      return 'Until ${dateFormat.format(endDate)}';
    }
    return '';
  }

  void _showAddDiscountDialog(BuildContext context) {
    _showDiscountFormDialog(context, null);
  }

  void _showEditDiscountDialog(BuildContext context, DiscountEntity discount) {
    _showDiscountFormDialog(context, discount);
  }

  void _showDiscountFormDialog(BuildContext context, DiscountEntity? discount) {
    final isEditing = discount != null;
    final formKey = GlobalKey<FormState>();
    
    String type = discount?.type ?? AppConstants.discountPercentage;
    double value = discount?.value ?? 10.0;
    String description = discount?.description ?? '';
    double? minOrderAmount = discount?.minOrderAmount;
    DateTime? startDate = discount?.startDate;
    DateTime? endDate = discount?.endDate;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(isEditing ? 'Edit Discount' : 'Add Discount'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: description,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'e.g., 10% off on all pizzas',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    onSaved: (value) => description = value!,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: type,
                    decoration: const InputDecoration(
                      labelText: 'Discount Type',
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: AppConstants.discountPercentage,
                        child: Text('Percentage'),
                      ),
                      const DropdownMenuItem(
                        value: AppConstants.discountFixed,
                        child: Text('Fixed Amount'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => type = value);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: value.toString(),
                    decoration: InputDecoration(
                      labelText: 'Discount Value',
                      hintText: type == AppConstants.discountPercentage ? 'e.g., 10' : 'e.g., 50',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a value';
                      }
                      final numValue = double.tryParse(value);
                      if (numValue == null || numValue <= 0) {
                        return 'Please enter a valid positive number';
                      }
                      if (type == AppConstants.discountPercentage && numValue > 100) {
                        return 'Percentage cannot exceed 100';
                      }
                      return null;
                    },
                    onSaved: (input) => value = double.parse(input!),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: minOrderAmount?.toString() ?? '',
                    decoration: const InputDecoration(
                      labelText: 'Minimum Order Amount (optional)',
                      hintText: 'e.g., 200',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        final numValue = double.tryParse(value);
                        if (numValue == null || numValue <= 0) {
                          return 'Please enter a valid positive number';
                        }
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        minOrderAmount = double.parse(value);
                      } else {
                        minOrderAmount = null;
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Start Date (optional)'),
                    subtitle: Text(startDate != null 
                        ? DateFormat('MMM dd, yyyy').format(startDate!)
                        : 'Not set'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() => startDate = picked);
                      }
                    },
                  ),
                  ListTile(
                    title: const Text('End Date (optional)'),
                    subtitle: Text(endDate != null 
                        ? DateFormat('MMM dd, yyyy').format(endDate!)
                        : 'Not set'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: endDate ?? DateTime.now().add(const Duration(days: 30)),
                        firstDate: startDate ?? DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() => endDate = picked);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  
                  final authState = context.read<AuthBloc>().state;
                  if (authState is AuthAuthenticated) {
                    if (isEditing) {
                      context.read<DiscountBloc>().add(
                        UpdateDiscount(
                          discountId: discount.discountId,
                          type: type,
                          value: value,
                          description: description,
                          startDate: startDate,
                          endDate: endDate,
                          minOrderAmount: minOrderAmount,
                          isActive: discount.isActive,
                        ),
                      );
                    } else {
                      context.read<DiscountBloc>().add(
                        AddDiscount(
                          vendorId: authState.userId,
                          type: type,
                          value: value,
                          description: description,
                          startDate: startDate,
                          endDate: endDate,
                          minOrderAmount: minOrderAmount,
                        ),
                      );
                    }
                  }
                  Navigator.pop(dialogContext);
                }
              },
              child: Text(isEditing ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _showToggleStatusDialog(BuildContext context, DiscountEntity discount) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(discount.isActive ? 'Deactivate Discount' : 'Activate Discount'),
        content: Text(
          'Are you sure you want to ${discount.isActive ? 'deactivate' : 'activate'} this discount?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<DiscountBloc>().add(
                ToggleDiscountStatus(
                  discountId: discount.discountId,
                  isActive: !discount.isActive,
                ),
              );
              Navigator.pop(dialogContext);
            },
            child: Text(discount.isActive ? 'Deactivate' : 'Activate'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDiscountDialog(BuildContext context, DiscountEntity discount) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Discount'),
        content: const Text(
          'Are you sure you want to delete this discount? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<DiscountBloc>().add(
                DeleteDiscount(discountId: discount.discountId),
              );
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
