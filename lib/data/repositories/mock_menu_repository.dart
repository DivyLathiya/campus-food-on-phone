import 'package:campus_food_app/data/datasources/mock_data_source.dart';
import 'package:campus_food_app/data/models/menu_item_model.dart';
import 'package:campus_food_app/domain/entities/menu_item_entity.dart';
import 'package:campus_food_app/domain/repositories/menu_repository.dart';

class MockMenuRepository implements MenuRepository {
  @override
  Future<List<MenuItemEntity>> getMenuItems(String vendorId) async {
    return getMenuItemsByVendor(vendorId);
  }

  @override
  Future<List<MenuItemEntity>> getMenuItemsByVendor(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final items = MockDataSource.getMenuItemsByVendor(vendorId);
    return items.map((item) => MenuItemEntity(
      menuItemId: item.menuItemId,
      vendorId: item.vendorId,
      name: item.name,
      description: item.description,
      price: item.price,
      imageUrl: item.imageUrl,
      isAvailable: item.isAvailable,
      category: item.category,
      preparationTime: item.preparationTime,
      tags: item.tags,
    )).toList();
  }

  @override
  Future<MenuItemEntity?> getMenuItemById(String menuItemId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      final item = MockDataSource.menuItems.firstWhere((i) => i.menuItemId == menuItemId);
      return MenuItemEntity(
        menuItemId: item.menuItemId,
        vendorId: item.vendorId,
        name: item.name,
        description: item.description,
        price: item.price,
        imageUrl: item.imageUrl,
        isAvailable: item.isAvailable,
        category: item.category,
        preparationTime: item.preparationTime,
        tags: item.tags,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<MenuItemEntity> addMenuItem(MenuItemEntity menuItem) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final newMenuItem = MenuItemModel(
      menuItemId: 'menu_${MockDataSource.menuItems.length + 1}',
      vendorId: menuItem.vendorId,
      name: menuItem.name,
      description: menuItem.description,
      price: menuItem.price,
      imageUrl: menuItem.imageUrl,
      isAvailable: menuItem.isAvailable,
      category: menuItem.category,
      preparationTime: menuItem.preparationTime,
      tags: menuItem.tags,
    );
    
    MockDataSource.menuItems.add(newMenuItem);
    
    return MenuItemEntity(
      menuItemId: newMenuItem.menuItemId,
      vendorId: newMenuItem.vendorId,
      name: newMenuItem.name,
      description: newMenuItem.description,
      price: newMenuItem.price,
      imageUrl: newMenuItem.imageUrl,
      isAvailable: newMenuItem.isAvailable,
      category: newMenuItem.category,
      preparationTime: newMenuItem.preparationTime,
      tags: newMenuItem.tags,
    );
  }

  @override
  Future<MenuItemEntity> updateMenuItem(MenuItemEntity menuItem) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.menuItems.indexWhere((i) => i.menuItemId == menuItem.menuItemId);
    if (index != -1) {
      final updatedItem = MockDataSource.menuItems[index].copyWith(
        name: menuItem.name,
        description: menuItem.description,
        price: menuItem.price,
        imageUrl: menuItem.imageUrl,
        isAvailable: menuItem.isAvailable,
        category: menuItem.category,
        preparationTime: menuItem.preparationTime,
        tags: menuItem.tags,
      );
      
      MockDataSource.menuItems[index] = updatedItem;
      
      return MenuItemEntity(
        menuItemId: updatedItem.menuItemId,
        vendorId: updatedItem.vendorId,
        name: updatedItem.name,
        description: updatedItem.description,
        price: updatedItem.price,
        imageUrl: updatedItem.imageUrl,
        isAvailable: updatedItem.isAvailable,
        category: updatedItem.category,
        preparationTime: updatedItem.preparationTime,
        tags: updatedItem.tags,
      );
    }
    
    throw Exception('Menu item not found');
  }

  @override
  Future<bool> deleteMenuItem(String menuItemId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final index = MockDataSource.menuItems.indexWhere((i) => i.menuItemId == menuItemId);
    if (index != -1) {
      MockDataSource.menuItems.removeAt(index);
      return true;
    }
    
    return false;
  }
}
