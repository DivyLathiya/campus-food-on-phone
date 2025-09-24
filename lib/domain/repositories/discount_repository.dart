import 'package:campus_food_app/domain/entities/discount_entity.dart';

abstract class DiscountRepository {
  Future<List<DiscountEntity>> getDiscountsByVendor(String vendorId);
  Future<DiscountEntity?> getDiscountById(String discountId);
  Future<DiscountEntity> createDiscount(DiscountEntity discount);
  Future<DiscountEntity> updateDiscount(DiscountEntity discount);
  Future<void> deleteDiscount(String discountId);
  Future<DiscountEntity?> getBestDiscountForVendor(String vendorId, double orderAmount);
}
