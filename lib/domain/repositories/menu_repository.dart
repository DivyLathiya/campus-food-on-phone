import 'package:campus_food_app/domain/entities/menu_item_entity.dart';

abstract class MenuRepository {
  Future<List<MenuItemEntity>> getMenuItems(String vendorId);
  Future<List<MenuItemEntity>> getMenuItemsByVendor(String vendorId);
  Future<MenuItemEntity?> getMenuItemById(String menuItemId);
  Future<MenuItemEntity> addMenuItem(MenuItemEntity menuItem);
  Future<MenuItemEntity> updateMenuItem(MenuItemEntity menuItem);
  Future<bool> deleteMenuItem(String menuItemId);
}
