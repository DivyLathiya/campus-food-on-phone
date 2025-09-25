import 'package:equatable/equatable.dart';

class EnhancedDiscountEntity extends Equatable {
  final String discountId;
  final String vendorId;
  final String type; // 'percentage', 'fixed', 'combo', 'happy_hour', 'wallet_only'
  final double value;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minOrderAmount;
  final bool isActive;
  
  // Combo deal specific fields
  final List<String>? requiredMenuItemIds;
  final double? comboPrice;
  final String? comboName;
  
  // Happy hour specific fields
  final List<int>? happyHourDays; // 1-7 (Monday-Sunday)
  final TimeOfDay? happyHourStartTime;
  final TimeOfDay? happyHourEndTime;
  final double? happyHourDiscountRate;
  
  // Additional fields
  final int? maxUsageCount;
  final int? currentUsageCount;
  final List<String>? applicableCategories;
  
  // Wallet-only discount specific fields
  final bool walletOnly;

  const EnhancedDiscountEntity({
    required this.discountId,
    required this.vendorId,
    required this.type,
    required this.value,
    required this.description,
    this.startDate,
    this.endDate,
    this.minOrderAmount,
    required this.isActive,
    this.requiredMenuItemIds,
    this.comboPrice,
    this.comboName,
    this.happyHourDays,
    this.happyHourStartTime,
    this.happyHourEndTime,
    this.happyHourDiscountRate,
    this.maxUsageCount,
    this.currentUsageCount,
    this.applicableCategories,
    this.walletOnly = false,
  });

  bool get isValid {
    final now = DateTime.now();
    if (!isActive) return false;
    if (startDate != null && now.isBefore(startDate!)) return false;
    if (endDate != null && now.isAfter(endDate!)) return false;
    if (startDate != null && endDate != null && startDate!.isAfter(endDate!)) return false;
    if (maxUsageCount != null && currentUsageCount != null && currentUsageCount! >= maxUsageCount!) return false;
    return true;
  }

  bool get isCurrentlyActive {
    final now = DateTime.now();
    if (!isValid) return false;
    
    if (type == 'happy_hour') {
      return _isHappyHourActive(now);
    }
    
    return true;
  }
  
  bool isApplicableToPaymentMethod(String paymentMethod) {
    if (walletOnly && paymentMethod.toLowerCase() != 'wallet') {
      return false;
    }
    return true;
  }

  bool _isHappyHourActive(DateTime now) {
    if (happyHourDays == null || happyHourStartTime == null || happyHourEndTime == null) {
      return false;
    }
    
    final currentDay = now.weekday; // 1 = Monday, 7 = Sunday
    if (!happyHourDays!.contains(currentDay)) {
      return false;
    }
    
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);
    return _isTimeInRange(currentTime, happyHourStartTime!, happyHourEndTime!);
  }

  bool _isTimeInRange(TimeOfDay time, TimeOfDay start, TimeOfDay end) {
    final currentMinutes = time.hour * 60 + time.minute;
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    
    if (endMinutes > startMinutes) {
      return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
    } else {
      // Handles overnight happy hours (e.g., 10 PM to 2 AM)
      return currentMinutes >= startMinutes || currentMinutes <= endMinutes;
    }
  }

  String? validate() {
    if (description.trim().isEmpty) {
      return 'Description cannot be empty';
    }
    
    if (value <= 0) {
      return 'Discount value must be greater than 0';
    }
    
    if (type == 'percentage' && value > 100) {
      return 'Percentage discount cannot exceed 100%';
    }
    
    if (minOrderAmount != null && minOrderAmount! <= 0) {
      return 'Minimum order amount must be greater than 0';
    }
    
    if (startDate != null && endDate != null && startDate!.isAfter(endDate!)) {
      return 'Start date must be before end date';
    }
    
    // Combo deal validation
    if (type == 'combo') {
      if (requiredMenuItemIds == null || requiredMenuItemIds!.isEmpty) {
        return 'Combo deals must have required menu items';
      }
      if (comboPrice == null || comboPrice! <= 0) {
        return 'Combo deals must have a valid combo price';
      }
      if (comboName == null || comboName!.trim().isEmpty) {
        return 'Combo deals must have a name';
      }
    }
    
    // Happy hour validation
    if (type == 'happy_hour') {
      if (happyHourDays == null || happyHourDays!.isEmpty) {
        return 'Happy hours must have selected days';
      }
      if (happyHourStartTime == null || happyHourEndTime == null) {
        return 'Happy hours must have start and end times';
      }
      if (happyHourDiscountRate == null || happyHourDiscountRate! <= 0) {
        return 'Happy hours must have a valid discount rate';
      }
      if (happyHourDiscountRate! > 100) {
        return 'Happy hour discount rate cannot exceed 100%';
      }
    }
    
    // Usage count validation
    if (maxUsageCount != null && maxUsageCount! <= 0) {
      return 'Max usage count must be greater than 0';
    }
    
    if (currentUsageCount != null && currentUsageCount! < 0) {
      return 'Current usage count cannot be negative';
    }
    
    return null; // No validation errors
  }

  bool isApplicableForOrder(double orderAmount, List<String> menuItemIds, List<String> categories) {
    if (!isValid) return false;
    
    // Check minimum order amount
    if (minOrderAmount != null && orderAmount < minOrderAmount!) return false;
    
    // Check usage count
    if (maxUsageCount != null && currentUsageCount != null && currentUsageCount! >= maxUsageCount!) return false;
    
    // Check happy hour timing
    if (type == 'happy_hour' && !_isHappyHourActive(DateTime.now())) return false;
    
    // Check combo deal requirements
    if (type == 'combo') {
      if (requiredMenuItemIds == null) return false;
      final hasAllRequiredItems = requiredMenuItemIds!.every((requiredId) => 
        menuItemIds.contains(requiredId));
      if (!hasAllRequiredItems) return false;
    }
    
    // Check category restrictions
    if (applicableCategories != null && applicableCategories!.isNotEmpty) {
      final hasApplicableCategory = categories.any((category) => 
        applicableCategories!.contains(category));
      if (!hasApplicableCategory) return false;
    }
    
    return true;
  }

  double calculateDiscount(double orderAmount, List<String> menuItemIds) {
    if (!isApplicableForOrder(orderAmount, menuItemIds, [])) {
      return 0.0;
    }

    switch (type) {
      case 'percentage':
        return orderAmount * (value / 100);
      case 'fixed':
        return value;
      case 'combo':
        if (comboPrice != null) {
          return orderAmount - comboPrice!;
        }
        return 0.0;
      case 'happy_hour':
        if (happyHourDiscountRate != null) {
          return orderAmount * (happyHourDiscountRate! / 100);
        }
        return 0.0;
      default:
        return 0.0;
    }
  }

  double getDiscountedAmount(double orderAmount, List<String> menuItemIds) {
    final discount = calculateDiscount(orderAmount, menuItemIds);
    return orderAmount - discount;
  }

  EnhancedDiscountEntity copyWith({
    String? discountId,
    String? vendorId,
    String? type,
    double? value,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    double? minOrderAmount,
    bool? isActive,
    List<String>? requiredMenuItemIds,
    double? comboPrice,
    String? comboName,
    List<int>? happyHourDays,
    TimeOfDay? happyHourStartTime,
    TimeOfDay? happyHourEndTime,
    double? happyHourDiscountRate,
    int? maxUsageCount,
    int? currentUsageCount,
    List<String>? applicableCategories,
  }) {
    return EnhancedDiscountEntity(
      discountId: discountId ?? this.discountId,
      vendorId: vendorId ?? this.vendorId,
      type: type ?? this.type,
      value: value ?? this.value,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      minOrderAmount: minOrderAmount ?? this.minOrderAmount,
      isActive: isActive ?? this.isActive,
      requiredMenuItemIds: requiredMenuItemIds ?? this.requiredMenuItemIds,
      comboPrice: comboPrice ?? this.comboPrice,
      comboName: comboName ?? this.comboName,
      happyHourDays: happyHourDays ?? this.happyHourDays,
      happyHourStartTime: happyHourStartTime ?? this.happyHourStartTime,
      happyHourEndTime: happyHourEndTime ?? this.happyHourEndTime,
      happyHourDiscountRate: happyHourDiscountRate ?? this.happyHourDiscountRate,
      maxUsageCount: maxUsageCount ?? this.maxUsageCount,
      currentUsageCount: currentUsageCount ?? this.currentUsageCount,
      applicableCategories: applicableCategories ?? this.applicableCategories,
    );
  }

  @override
  List<Object?> get props {
    return [
      discountId,
      vendorId,
      type,
      value,
      description,
      startDate,
      endDate,
      minOrderAmount,
      isActive,
      requiredMenuItemIds,
      comboPrice,
      comboName,
      happyHourDays,
      happyHourStartTime,
      happyHourEndTime,
      happyHourDiscountRate,
      maxUsageCount,
      currentUsageCount,
      applicableCategories,
      walletOnly,
    ];
  }
}

class TimeOfDay extends Equatable {
  final int hour;
  final int minute;

  const TimeOfDay({
    required this.hour,
    required this.minute,
  });

  @override
  List<Object> get props => [hour, minute];
}
