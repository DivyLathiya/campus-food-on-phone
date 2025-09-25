import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:campus_food_app/presentation/vendor/bloc/menu_bloc.dart';
import 'package:campus_food_app/domain/entities/menu_item_entity.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';

class MenuManagementScreen extends StatefulWidget {
  const MenuManagementScreen({super.key});

  @override
  _MenuManagementScreenState createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<MenuBloc>().add(LoadMenuItems(vendorId: authState.userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddMenuItemDialog(context),
          ),
        ],
      ),
      body: BlocConsumer<MenuBloc, MenuState>(
        listener: (context, state) {
          if (state is MenuOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.successColor,
              ),
            );
          } else if (state is MenuError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is MenuLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MenuLoaded || state is MenuOperationSuccess) {
            final menuItems = state is MenuLoaded 
                ? state.menuItems 
                : (state as MenuOperationSuccess).menuItems;
            
            if (menuItems.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant_menu, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No menu items available',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tap the + button to add your first menu item',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            // Group menu items by category
            final categories = _groupItemsByCategory(menuItems);
            
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories.keys.elementAt(index);
                final items = categories[category] ?? [];
                return _buildCategorySection(context, category, items);
              },
            );
          } else if (state is MenuError) {
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
                        context.read<MenuBloc>().add(LoadMenuItems(vendorId: authState.userId));
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

  Map<String, List<MenuItemEntity>> _groupItemsByCategory(List<MenuItemEntity> items) {
    final Map<String, List<MenuItemEntity>> grouped = {};
    
    for (final item in items) {
      final category = item.category ?? 'Uncategorized';
      if (!grouped.containsKey(category)) {
        grouped[category] = [];
      }
      grouped[category]?.add(item);
    }
    
    return grouped;
  }

  Widget _buildCategorySection(BuildContext context, String category, List<MenuItemEntity> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => _buildMenuItemCard(context, item)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildMenuItemCard(BuildContext context, MenuItemEntity item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Item Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[300],
                    child: const Icon(Icons.restaurant, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: item.isAvailable ? AppTheme.successColor : Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.isAvailable ? 'Available' : 'Unavailable',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '₹${item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      if (item.preparationTime != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          '${item.preparationTime} min',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            // Action Buttons
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    item.isAvailable ? Icons.visibility_off : Icons.visibility,
                    color: item.isAvailable ? Colors.orange : AppTheme.successColor,
                  ),
                  onPressed: () => _showToggleAvailabilityDialog(context, item),
                  tooltip: item.isAvailable ? 'Mark Unavailable' : 'Mark Available',
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditMenuItemDialog(context, item),
                  tooltip: 'Edit Item',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _showDeleteMenuItemDialog(context, item),
                  tooltip: 'Delete Item',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMenuItemDialog(BuildContext context) {
    _showMenuItemFormDialog(context, null);
  }

  void _showEditMenuItemDialog(BuildContext context, MenuItemEntity item) {
    _showMenuItemFormDialog(context, item);
  }

  void _showMenuItemFormDialog(BuildContext context, MenuItemEntity? item) {
    final isEditing = item != null;
    final formKey = GlobalKey<FormState>();
    
    String name = item?.name ?? '';
    String description = item?.description ?? '';
    double price = item?.price ?? 0.0;
    String imageUrl = item?.imageUrl ?? '';
    bool isAvailable = item?.isAvailable ?? true;
    String? category = item?.category;
    int? preparationTime = item?.preparationTime;
    List<String> tags = item?.tags ?? [];

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(isEditing ? 'Edit Menu Item' : 'Add Menu Item'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: name,
                    decoration: const InputDecoration(
                      labelText: 'Item Name *',
                      hintText: 'e.g., Margherita Pizza',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter item name';
                      }
                      return null;
                    },
                    onSaved: (value) => name = value!,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: description,
                    decoration: const InputDecoration(
                      labelText: 'Description *',
                      hintText: 'e.g., Classic pizza with tomato sauce and mozzarella',
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                    onSaved: (value) => description = value!,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: price.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Price (₹) *',
                      hintText: 'e.g., 299',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter price';
                      }
                      final numValue = double.tryParse(value);
                      if (numValue == null || numValue <= 0) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                    onSaved: (value) => price = double.parse(value!),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: imageUrl,
                    decoration: const InputDecoration(
                      labelText: 'Image URL *',
                      hintText: 'e.g., https://example.com/image.jpg',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter image URL';
                      }
                      return null;
                    },
                    onSaved: (value) => imageUrl = value!,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String?>(
                    value: category,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                    ),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('Uncategorized'),
                      ),
                      const DropdownMenuItem(
                        value: 'Main Course',
                        child: Text('Main Course'),
                      ),
                      const DropdownMenuItem(
                        value: 'Appetizers',
                        child: Text('Appetizers'),
                      ),
                      const DropdownMenuItem(
                        value: 'Desserts',
                        child: Text('Desserts'),
                      ),
                      const DropdownMenuItem(
                        value: 'Beverages',
                        child: Text('Beverages'),
                      ),
                      const DropdownMenuItem(
                        value: 'Snacks',
                        child: Text('Snacks'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => category = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: preparationTime?.toString() ?? '',
                    decoration: const InputDecoration(
                      labelText: 'Preparation Time (minutes, optional)',
                      hintText: 'e.g., 15',
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        preparationTime = int.parse(value);
                      } else {
                        preparationTime = null;
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Available'),
                    value: isAvailable,
                    onChanged: (value) {
                      setState(() => isAvailable = value);
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
                      context.read<MenuBloc>().add(
                        UpdateMenuItem(
                          menuItemId: item.menuItemId,
                          name: name,
                          description: description,
                          price: price,
                          imageUrl: imageUrl,
                          isAvailable: isAvailable,
                          category: category,
                          preparationTime: preparationTime,
                          tags: tags,
                        ),
                      );
                    } else {
                      context.read<MenuBloc>().add(
                        AddMenuItem(
                          vendorId: authState.userId,
                          name: name,
                          description: description,
                          price: price,
                          imageUrl: imageUrl,
                          isAvailable: isAvailable,
                          category: category,
                          preparationTime: preparationTime,
                          tags: tags,
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

  void _showToggleAvailabilityDialog(BuildContext context, MenuItemEntity item) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(item.isAvailable ? 'Mark Unavailable' : 'Mark Available'),
        content: Text(
          'Are you sure you want to ${item.isAvailable ? 'mark this item unavailable' : 'mark this item available'}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<MenuBloc>().add(
                ToggleMenuItemAvailability(
                  menuItemId: item.menuItemId,
                  isAvailable: !item.isAvailable,
                ),
              );
              Navigator.pop(dialogContext);
            },
            child: Text(item.isAvailable ? 'Mark Unavailable' : 'Mark Available'),
          ),
        ],
      ),
    );
  }

  void _showDeleteMenuItemDialog(BuildContext context, MenuItemEntity item) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Menu Item'),
        content: Text(
          'Are you sure you want to delete "${item.name}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<MenuBloc>().add(
                DeleteMenuItem(menuItemId: item.menuItemId),
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
