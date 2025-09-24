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
    ];
  }
}
