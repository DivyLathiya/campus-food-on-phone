import 'package:equatable/equatable.dart';

class MenuItemEntity extends Equatable {
  final String menuItemId;
  final String vendorId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isAvailable;
  final String? category;
  final int? preparationTime;
  final List<String>? tags;
  final int? stockQuantity;
  final bool? isOutOfStock;
  final DateTime? lastStockUpdate;

  const MenuItemEntity({
    required this.menuItemId,
    required this.vendorId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isAvailable,
    this.category,
    this.preparationTime,
    this.tags,
    this.stockQuantity,
    this.isOutOfStock,
    this.lastStockUpdate,
  });

  @override
  List<Object?> get props {
    return [
      menuItemId,
      vendorId,
      name,
      description,
      price,
      imageUrl,
      isAvailable,
      category,
      preparationTime,
      tags,
      stockQuantity,
      isOutOfStock,
      lastStockUpdate,
    ];
  }
  
  bool get isInStock => (isOutOfStock == null || !isOutOfStock!) && (stockQuantity == null || stockQuantity! > 0);
  
  bool get hasLowStock => stockQuantity != null && stockQuantity! > 0 && stockQuantity! <= 5;
}
