import 'package:campus_food_app/domain/entities/enhanced_discount_entity.dart';

abstract class EnhancedDiscountRepository {
  Future<List<EnhancedDiscountEntity>> getDiscountsByVendor(String vendorId);
  Future<EnhancedDiscountEntity?> getDiscountById(String discountId);
  Future<EnhancedDiscountEntity> addDiscount(EnhancedDiscountEntity discount);
  Future<EnhancedDiscountEntity> updateDiscount(EnhancedDiscountEntity discount);
  Future<bool> deleteDiscount(String discountId);
  Future<List<EnhancedDiscountEntity>> getActiveDiscounts(String vendorId);
  Future<List<EnhancedDiscountEntity>> getComboDeals(String vendorId);
  Future<List<EnhancedDiscountEntity>> getHappyHours(String vendorId);
  Future<EnhancedDiscountEntity?> getBestApplicableDiscount(
    String vendorId,
    double orderAmount,
    List<String> menuItemIds,
    List<String> categories,
  );
  Future<bool> incrementDiscountUsage(String discountId);
  Future<List<EnhancedDiscountEntity>> getDiscountsByCategory(String vendorId, String category);
}
