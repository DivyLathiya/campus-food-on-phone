part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class LoadMenuItems extends MenuEvent {
  final String vendorId;

  const LoadMenuItems({required this.vendorId});

  @override
  List<Object> get props => [vendorId];
}

class AddMenuItem extends MenuEvent {
  final String vendorId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isAvailable;
  final String? category;
  final int? preparationTime;
  final List<String>? tags;

  const AddMenuItem({
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
  List<Object> get props => [
        vendorId,
        name,
        description,
        price,
        imageUrl,
        isAvailable,
        category ?? '',
        preparationTime ?? 0,
        tags ?? [],
      ];
}

class UpdateMenuItem extends MenuEvent {
  final String menuItemId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isAvailable;
  final String? category;
  final int? preparationTime;
  final List<String>? tags;

  const UpdateMenuItem({
    required this.menuItemId,
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
  List<Object> get props => [
        menuItemId,
        name,
        description,
        price,
        imageUrl,
        isAvailable,
        category ?? '',
        preparationTime ?? 0,
        tags ?? [],
      ];
}

class DeleteMenuItem extends MenuEvent {
  final String menuItemId;

  const DeleteMenuItem({required this.menuItemId});

  @override
  List<Object> get props => [menuItemId];
}

class ToggleMenuItemAvailability extends MenuEvent {
  final String menuItemId;
  final bool isAvailable;

  const ToggleMenuItemAvailability({
    required this.menuItemId,
    required this.isAvailable,
  });

  @override
  List<Object> get props => [menuItemId, isAvailable];
}
