import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/menu_item_entity.dart';

class MenuItemModel extends Equatable {
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

  const MenuItemModel({
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

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      menuItemId: json['menuItemId'] as String,
      vendorId: json['vendorId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      isAvailable: json['isAvailable'] as bool,
      category: json['category'] as String?,
      preparationTime: json['preparationTime'] as int?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
      stockQuantity: json['stockQuantity'] as int?,
      isOutOfStock: json['isOutOfStock'] as bool?,
      lastStockUpdate: json['lastStockUpdate'] != null 
          ? DateTime.parse(json['lastStockUpdate'] as String) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuItemId': menuItemId,
      'vendorId': vendorId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'category': category,
      'preparationTime': preparationTime,
      'tags': tags,
      'stockQuantity': stockQuantity,
      'isOutOfStock': isOutOfStock,
      'lastStockUpdate': lastStockUpdate?.toIso8601String(),
    };
  }

  MenuItemModel copyWith({
    String? menuItemId,
    String? vendorId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    bool? isAvailable,
    String? category,
    int? preparationTime,
    List<String>? tags,
    int? stockQuantity,
    bool? isOutOfStock,
    DateTime? lastStockUpdate,
  }) {
    return MenuItemModel(
      menuItemId: menuItemId ?? this.menuItemId,
      vendorId: vendorId ?? this.vendorId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      category: category ?? this.category,
      preparationTime: preparationTime ?? this.preparationTime,
      tags: tags ?? this.tags,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isOutOfStock: isOutOfStock ?? this.isOutOfStock,
      lastStockUpdate: lastStockUpdate ?? this.lastStockUpdate,
    );
  }

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
  
  factory MenuItemModel.fromEntity(MenuItemEntity entity) {
    return MenuItemModel(
      menuItemId: entity.menuItemId,
      vendorId: entity.vendorId,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      imageUrl: entity.imageUrl,
      isAvailable: entity.isAvailable,
      category: entity.category,
      preparationTime: entity.preparationTime,
      tags: entity.tags,
      stockQuantity: entity.stockQuantity,
      isOutOfStock: entity.isOutOfStock,
      lastStockUpdate: entity.lastStockUpdate,
    );
  }
  
  MenuItemEntity toEntity() {
    return MenuItemEntity(
      menuItemId: menuItemId,
      vendorId: vendorId,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      isAvailable: isAvailable,
      category: category,
      preparationTime: preparationTime,
      tags: tags,
      stockQuantity: stockQuantity,
      isOutOfStock: isOutOfStock,
      lastStockUpdate: lastStockUpdate,
    );
  }
  
  bool get isInStock => (isOutOfStock == null || !isOutOfStock!) && (stockQuantity == null || stockQuantity! > 0);
  
  bool get hasLowStock => stockQuantity != null && stockQuantity! > 0 && stockQuantity! <= 5;
}
