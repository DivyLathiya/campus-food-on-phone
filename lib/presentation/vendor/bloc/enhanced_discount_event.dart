part of 'enhanced_discount_bloc.dart';

abstract class EnhancedDiscountEvent extends Equatable {
  const EnhancedDiscountEvent();

  @override
  List<Object> get props => [];
}

class LoadEnhancedDiscounts extends EnhancedDiscountEvent {
  final String vendorId;

  const LoadEnhancedDiscounts({required this.vendorId});

  @override
  List<Object> get props => [vendorId];
}

class LoadActiveDiscounts extends EnhancedDiscountEvent {
  final String vendorId;

  const LoadActiveDiscounts({required this.vendorId});

  @override
  List<Object> get props => [vendorId];
}

class LoadComboDeals extends EnhancedDiscountEvent {
  final String vendorId;

  const LoadComboDeals({required this.vendorId});

  @override
  List<Object> get props => [vendorId];
}

class LoadHappyHours extends EnhancedDiscountEvent {
  final String vendorId;

  const LoadHappyHours({required this.vendorId});

  @override
  List<Object> get props => [vendorId];
}

class AddEnhancedDiscount extends EnhancedDiscountEvent {
  final String vendorId;
  final String type;
  final double value;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minOrderAmount;
  final List<String>? requiredMenuItemIds;
  final double? comboPrice;
  final String? comboName;
  final List<int>? happyHourDays;
  final TimeOfDay? happyHourStartTime;
  final TimeOfDay? happyHourEndTime;
  final double? happyHourDiscountRate;
  final int? maxUsageCount;
  final List<String>? applicableCategories;

  const AddEnhancedDiscount({
    required this.vendorId,
    required this.type,
    required this.value,
    required this.description,
    this.startDate,
    this.endDate,
    this.minOrderAmount,
    this.requiredMenuItemIds,
    this.comboPrice,
    this.comboName,
    this.happyHourDays,
    this.happyHourStartTime,
    this.happyHourEndTime,
    this.happyHourDiscountRate,
    this.maxUsageCount,
    this.applicableCategories,
  });

  @override
  List<Object> get props => [
        vendorId,
        type,
        value,
        description,
        startDate ?? DateTime.now(),
        endDate ?? DateTime.now(),
        minOrderAmount ?? 0.0,
        requiredMenuItemIds ?? [],
        comboPrice ?? 0.0,
        comboName ?? '',
        happyHourDays ?? [],
        happyHourStartTime ?? const TimeOfDay(hour: 0, minute: 0),
        happyHourEndTime ?? const TimeOfDay(hour: 0, minute: 0),
        happyHourDiscountRate ?? 0.0,
        maxUsageCount ?? 0,
        applicableCategories ?? [],
      ];
}

class UpdateEnhancedDiscount extends EnhancedDiscountEvent {
  final String discountId;
  final String type;
  final double value;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minOrderAmount;
  final List<String>? requiredMenuItemIds;
  final double? comboPrice;
  final String? comboName;
  final List<int>? happyHourDays;
  final TimeOfDay? happyHourStartTime;
  final TimeOfDay? happyHourEndTime;
  final double? happyHourDiscountRate;
  final int? maxUsageCount;
  final List<String>? applicableCategories;

  const UpdateEnhancedDiscount({
    required this.discountId,
    required this.type,
    required this.value,
    required this.description,
    this.startDate,
    this.endDate,
    this.minOrderAmount,
    this.requiredMenuItemIds,
    this.comboPrice,
    this.comboName,
    this.happyHourDays,
    this.happyHourStartTime,
    this.happyHourEndTime,
    this.happyHourDiscountRate,
    this.maxUsageCount,
    this.applicableCategories,
  });

  @override
  List<Object> get props => [
        discountId,
        type,
        value,
        description,
        startDate ?? DateTime.now(),
        endDate ?? DateTime.now(),
        minOrderAmount ?? 0.0,
        requiredMenuItemIds ?? [],
        comboPrice ?? 0.0,
        comboName ?? '',
        happyHourDays ?? [],
        happyHourStartTime ?? const TimeOfDay(hour: 0, minute: 0),
        happyHourEndTime ?? const TimeOfDay(hour: 0, minute: 0),
        happyHourDiscountRate ?? 0.0,
        maxUsageCount ?? 0,
        applicableCategories ?? [],
      ];
}

class DeleteEnhancedDiscount extends EnhancedDiscountEvent {
  final String discountId;

  const DeleteEnhancedDiscount({required this.discountId});

  @override
  List<Object> get props => [discountId];
}

class ToggleEnhancedDiscountStatus extends EnhancedDiscountEvent {
  final String discountId;
  final bool isActive;

  const ToggleEnhancedDiscountStatus({
    required this.discountId,
    required this.isActive,
  });

  @override
  List<Object> get props => [discountId, isActive];
}

class GetBestApplicableDiscount extends EnhancedDiscountEvent {
  final String vendorId;
  final double orderAmount;
  final List<String> menuItemIds;
  final List<String> categories;

  const GetBestApplicableDiscount({
    required this.vendorId,
    required this.orderAmount,
    required this.menuItemIds,
    required this.categories,
  });

  @override
  List<Object> get props => [vendorId, orderAmount, menuItemIds, categories];
}
