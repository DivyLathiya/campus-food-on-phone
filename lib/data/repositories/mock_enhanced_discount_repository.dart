import 'package:campus_food_app/data/datasources/mock_data_source.dart';
import 'package:campus_food_app/data/models/enhanced_discount_model.dart';
import 'package:campus_food_app/domain/entities/enhanced_discount_entity.dart';
import 'package:campus_food_app/domain/repositories/enhanced_discount_repository.dart';

class MockEnhancedDiscountRepository implements EnhancedDiscountRepository {
  @override
  Future<List<EnhancedDiscountEntity>> getDiscountsByVendor(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final discounts = MockDataSource.getEnhancedDiscountsByVendor(vendorId);
    return discounts.map((discount) => EnhancedDiscountEntity(
      discountId: discount.discountId,
      vendorId: discount.vendorId,
      type: discount.type,
      value: discount.value,
      description: discount.description,
      startDate: discount.startDate,
      endDate: discount.endDate,
      minOrderAmount: discount.minOrderAmount,
      isActive: discount.isActive,
      requiredMenuItemIds: discount.requiredMenuItemIds,
      comboPrice: discount.comboPrice,
      comboName: discount.comboName,
      happyHourDays: discount.happyHourDays,
      happyHourStartTime: discount.happyHourStartTime,
      happyHourEndTime: discount.happyHourEndTime,
      happyHourDiscountRate: discount.happyHourDiscountRate,
      maxUsageCount: discount.maxUsageCount,
      currentUsageCount: discount.currentUsageCount,
      applicableCategories: discount.applicableCategories,
      walletOnly: discount.walletOnly,
    )).toList();
  }

  @override
  Future<EnhancedDiscountEntity?> getDiscountById(String discountId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      final discount = MockDataSource.enhancedDiscounts.firstWhere((d) => d.discountId == discountId);
      return EnhancedDiscountEntity(
        discountId: discount.discountId,
        vendorId: discount.vendorId,
        type: discount.type,
        value: discount.value,
        description: discount.description,
        startDate: discount.startDate,
        endDate: discount.endDate,
        minOrderAmount: discount.minOrderAmount,
        isActive: discount.isActive,
        requiredMenuItemIds: discount.requiredMenuItemIds,
        comboPrice: discount.comboPrice,
        comboName: discount.comboName,
        happyHourDays: discount.happyHourDays,
        happyHourStartTime: discount.happyHourStartTime,
        happyHourEndTime: discount.happyHourEndTime,
        happyHourDiscountRate: discount.happyHourDiscountRate,
        maxUsageCount: discount.maxUsageCount,
        currentUsageCount: discount.currentUsageCount,
        applicableCategories: discount.applicableCategories,
        walletOnly: discount.walletOnly,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<EnhancedDiscountEntity> addDiscount(EnhancedDiscountEntity discount) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final newDiscount = EnhancedDiscountModel(
      discountId: 'discount_${MockDataSource.enhancedDiscounts.length + 1}',
      vendorId: discount.vendorId,
      title: discount.description,
      type: discount.type,
      value: discount.value,
      description: discount.description,
      startDate: discount.startDate,
      endDate: discount.endDate,
      minOrderAmount: discount.minOrderAmount,
      isActive: discount.isActive,
      requiredMenuItemIds: discount.requiredMenuItemIds,
      comboPrice: discount.comboPrice,
      comboName: discount.comboName,
      happyHourDays: discount.happyHourDays,
      happyHourStartTime: discount.happyHourStartTime,
      happyHourEndTime: discount.happyHourEndTime,
      happyHourDiscountRate: discount.happyHourDiscountRate,
      maxUsageCount: discount.maxUsageCount,
      currentUsageCount: discount.currentUsageCount ?? 0,
      applicableCategories: discount.applicableCategories,
      walletOnly: discount.walletOnly,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    MockDataSource.enhancedDiscounts.add(newDiscount);
    
    return EnhancedDiscountEntity(
      discountId: newDiscount.discountId,
      vendorId: newDiscount.vendorId,
      type: newDiscount.type,
      value: newDiscount.value,
      description: newDiscount.description,
      startDate: newDiscount.startDate,
      endDate: newDiscount.endDate,
      minOrderAmount: newDiscount.minOrderAmount,
      isActive: newDiscount.isActive,
      requiredMenuItemIds: newDiscount.requiredMenuItemIds,
      comboPrice: newDiscount.comboPrice,
      comboName: newDiscount.comboName,
      happyHourDays: newDiscount.happyHourDays,
      happyHourStartTime: newDiscount.happyHourStartTime,
      happyHourEndTime: newDiscount.happyHourEndTime,
      happyHourDiscountRate: newDiscount.happyHourDiscountRate,
      maxUsageCount: newDiscount.maxUsageCount,
      currentUsageCount: newDiscount.currentUsageCount,
      applicableCategories: newDiscount.applicableCategories,
      walletOnly: newDiscount.walletOnly,
    );
  }

  @override
  Future<EnhancedDiscountEntity> updateDiscount(EnhancedDiscountEntity discount) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.enhancedDiscounts.indexWhere((d) => d.discountId == discount.discountId);
    if (index != -1) {
      final updatedDiscount = MockDataSource.enhancedDiscounts[index].copyWith(
        type: discount.type,
        value: discount.value,
        description: discount.description,
        startDate: discount.startDate,
        endDate: discount.endDate,
        minOrderAmount: discount.minOrderAmount,
        isActive: discount.isActive,
        requiredMenuItemIds: discount.requiredMenuItemIds,
        comboPrice: discount.comboPrice,
        comboName: discount.comboName,
        happyHourDays: discount.happyHourDays,
        happyHourStartTime: discount.happyHourStartTime,
        happyHourEndTime: discount.happyHourEndTime,
        happyHourDiscountRate: discount.happyHourDiscountRate,
        maxUsageCount: discount.maxUsageCount,
        currentUsageCount: discount.currentUsageCount,
        applicableCategories: discount.applicableCategories,
        walletOnly: discount.walletOnly,
      );
      
      MockDataSource.enhancedDiscounts[index] = updatedDiscount;
      
      return EnhancedDiscountEntity(
        discountId: updatedDiscount.discountId,
        vendorId: updatedDiscount.vendorId,
        type: updatedDiscount.type,
        value: updatedDiscount.value,
        description: updatedDiscount.description,
        startDate: updatedDiscount.startDate,
        endDate: updatedDiscount.endDate,
        minOrderAmount: updatedDiscount.minOrderAmount,
        isActive: updatedDiscount.isActive,
        requiredMenuItemIds: updatedDiscount.requiredMenuItemIds,
        comboPrice: updatedDiscount.comboPrice,
        comboName: updatedDiscount.comboName,
        happyHourDays: updatedDiscount.happyHourDays,
        happyHourStartTime: updatedDiscount.happyHourStartTime,
        happyHourEndTime: updatedDiscount.happyHourEndTime,
        happyHourDiscountRate: updatedDiscount.happyHourDiscountRate,
        maxUsageCount: updatedDiscount.maxUsageCount,
        currentUsageCount: updatedDiscount.currentUsageCount,
        applicableCategories: updatedDiscount.applicableCategories,
        walletOnly: updatedDiscount.walletOnly,
      );
    }
    
    throw Exception('Discount not found');
  }

  @override
  Future<bool> deleteDiscount(String discountId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final index = MockDataSource.enhancedDiscounts.indexWhere((d) => d.discountId == discountId);
    if (index != -1) {
      MockDataSource.enhancedDiscounts.removeAt(index);
      return true;
    }
    
    return false;
  }

  @override
  Future<List<EnhancedDiscountEntity>> getActiveDiscounts(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final allDiscounts = await getDiscountsByVendor(vendorId);
    return allDiscounts.where((discount) => discount.isValid).toList();
  }

  @override
  Future<List<EnhancedDiscountEntity>> getComboDeals(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final allDiscounts = await getDiscountsByVendor(vendorId);
    return allDiscounts.where((discount) => 
      discount.type == 'combo' && discount.isValid
    ).toList();
  }

  @override
  Future<List<EnhancedDiscountEntity>> getHappyHours(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final allDiscounts = await getDiscountsByVendor(vendorId);
    return allDiscounts.where((discount) => 
      discount.type == 'happy_hour' && discount.isValid
    ).toList();
  }

  @override
  Future<EnhancedDiscountEntity?> getBestApplicableDiscount(
    String vendorId,
    double orderAmount,
    List<String> menuItemIds,
    List<String> categories,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final activeDiscounts = await getActiveDiscounts(vendorId);
    final applicableDiscounts = activeDiscounts.where((discount) => 
      discount.isApplicableForOrder(orderAmount, menuItemIds, categories)
    ).toList();
    
    if (applicableDiscounts.isEmpty) {
      return null;
    }
    
    // Find the discount that provides the maximum savings
    EnhancedDiscountEntity? bestDiscount;
    double maxSavings = 0.0;
    
    for (final discount in applicableDiscounts) {
      final savings = discount.calculateDiscount(orderAmount, menuItemIds);
      if (savings > maxSavings) {
        maxSavings = savings;
        bestDiscount = discount;
      }
    }
    
    return bestDiscount;
  }

  @override
  Future<bool> incrementDiscountUsage(String discountId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    
    final index = MockDataSource.enhancedDiscounts.indexWhere((d) => d.discountId == discountId);
    if (index != -1) {
      final discount = MockDataSource.enhancedDiscounts[index];
      final updatedDiscount = discount.copyWith(
        currentUsageCount: (discount.currentUsageCount ?? 0) + 1,
      );
      MockDataSource.enhancedDiscounts[index] = updatedDiscount;
      return true;
    }
    
    return false;
  }

  @override
  Future<List<EnhancedDiscountEntity>> getDiscountsByCategory(String vendorId, String category) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final allDiscounts = await getDiscountsByVendor(vendorId);
    return allDiscounts.where((discount) => 
      discount.applicableCategories?.contains(category) ?? false
    ).toList();
  }
}
