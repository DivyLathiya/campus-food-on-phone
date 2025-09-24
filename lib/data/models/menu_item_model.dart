import 'package:equatable/equatable.dart';

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
    ];
  }
}
