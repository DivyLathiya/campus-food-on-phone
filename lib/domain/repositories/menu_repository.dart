import 'package:campus_food_app/domain/entities/menu_item_entity.dart';

abstract class MenuRepository {
  Future<List<MenuItemEntity>> getMenuItems(String vendorId);
  Future<List<MenuItemEntity>> getMenuItemsByVendor(String vendorId);
  Future<MenuItemEntity?> getMenuItemById(String menuItemId);
  Future<MenuItemEntity> addMenuItem(MenuItemEntity menuItem);
  Future<MenuItemEntity> updateMenuItem(MenuItemEntity menuItem);
  Future<bool> deleteMenuItem(String menuItemId);
  
  // Stock management methods
  Future<MenuItemEntity> updateStock(String menuItemId, int newQuantity);
  Future<MenuItemEntity> setOutOfStock(String menuItemId, bool isOutOfStock);
  Future<List<MenuItemEntity>> getLowStockItems(String vendorId);
  Future<List<MenuItemEntity>> getOutOfStockItems(String vendorId);
  Future<bool> checkStockAvailability(String menuItemId, int requiredQuantity);
  Future<Map<String, dynamic>> getStockAnalytics(String vendorId);
}
