import 'package:campus_food_app/data/datasources/mock_data_source.dart';
import 'package:campus_food_app/data/models/discount_model.dart';
import 'package:campus_food_app/domain/entities/discount_entity.dart';
import 'package:campus_food_app/domain/repositories/discount_repository.dart';

class MockDiscountRepository implements DiscountRepository {
  @override
  Future<List<DiscountEntity>> getDiscountsByVendor(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final vendorDiscounts = MockDataSource.discounts
        .where((discount) => discount.vendorId == vendorId)
        .toList();
    
    return vendorDiscounts.map((discount) => DiscountEntity(
      discountId: discount.discountId,
      vendorId: discount.vendorId,
      type: discount.type,
      value: discount.value,
      description: discount.description,
      startDate: discount.startDate,
      endDate: discount.endDate,
      minOrderAmount: discount.minOrderAmount,
      isActive: discount.isActive,
    )).toList();
  }

  @override
  Future<DiscountEntity?> getDiscountById(String discountId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      final discount = MockDataSource.discounts.firstWhere((d) => d.discountId == discountId);
      return DiscountEntity(
        discountId: discount.discountId,
        vendorId: discount.vendorId,
        type: discount.type,
        value: discount.value,
        description: discount.description,
        startDate: discount.startDate,
        endDate: discount.endDate,
        minOrderAmount: discount.minOrderAmount,
        isActive: discount.isActive,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<DiscountEntity> createDiscount(DiscountEntity discount) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final newDiscount = DiscountModel(
      discountId: 'discount_${MockDataSource.discounts.length + 1}',
      vendorId: discount.vendorId,
      type: discount.type,
      value: discount.value,
      description: discount.description,
      startDate: discount.startDate,
      endDate: discount.endDate,
      minOrderAmount: discount.minOrderAmount,
      isActive: discount.isActive,
    );
    
    MockDataSource.discounts.add(newDiscount);
    
    return DiscountEntity(
      discountId: newDiscount.discountId,
      vendorId: newDiscount.vendorId,
      type: newDiscount.type,
      value: newDiscount.value,
      description: newDiscount.description,
      startDate: newDiscount.startDate,
      endDate: newDiscount.endDate,
      minOrderAmount: newDiscount.minOrderAmount,
      isActive: newDiscount.isActive,
    );
  }

  @override
  Future<DiscountEntity> updateDiscount(DiscountEntity discount) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.discounts.indexWhere((d) => d.discountId == discount.discountId);
    if (index != -1) {
      final updatedDiscount = MockDataSource.discounts[index].copyWith(
        type: discount.type,
        value: discount.value,
        description: discount.description,
        startDate: discount.startDate,
        endDate: discount.endDate,
        minOrderAmount: discount.minOrderAmount,
        isActive: discount.isActive,
      );
      
      MockDataSource.discounts[index] = updatedDiscount;
      
      return DiscountEntity(
        discountId: updatedDiscount.discountId,
        vendorId: updatedDiscount.vendorId,
        type: updatedDiscount.type,
        value: updatedDiscount.value,
        description: updatedDiscount.description,
        startDate: updatedDiscount.startDate,
        endDate: updatedDiscount.endDate,
        minOrderAmount: updatedDiscount.minOrderAmount,
        isActive: updatedDiscount.isActive,
      );
    }
    
    throw Exception('Discount not found');
  }

  @override
  Future<void> deleteDiscount(String discountId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final index = MockDataSource.discounts.indexWhere((d) => d.discountId == discountId);
    if (index != -1) {
      MockDataSource.discounts.removeAt(index);
    } else {
      throw Exception('Discount not found');
    }
  }

  @override
  Future<DiscountEntity?> getBestDiscountForVendor(String vendorId, double orderAmount) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final vendorDiscounts = MockDataSource.discounts
        .where((discount) => discount.vendorId == vendorId && discount.isActive)
        .toList();
    
    DiscountEntity? bestDiscount;
    double maxDiscount = 0.0;
    
    for (final discountModel in vendorDiscounts) {
      final discount = DiscountEntity(
        discountId: discountModel.discountId,
        vendorId: discountModel.vendorId,
        type: discountModel.type,
        value: discountModel.value,
        description: discountModel.description,
        startDate: discountModel.startDate,
        endDate: discountModel.endDate,
        minOrderAmount: discountModel.minOrderAmount,
        isActive: discountModel.isActive,
      );
      
      if (discount.isValid) {
        final discountAmount = discount.calculateDiscount(orderAmount);
        if (discountAmount > maxDiscount) {
          maxDiscount = discountAmount;
          bestDiscount = discount;
        }
      }
    }
    
    return bestDiscount;
  }
}
