import 'package:equatable/equatable.dart';

class DiscountEntity extends Equatable {
  final String discountId;
  final String vendorId;
  final String type;
  final double value;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minOrderAmount;
  final bool isActive;

  const DiscountEntity({
    required this.discountId,
    required this.vendorId,
    required this.type,
    required this.value,
    required this.description,
    this.startDate,
    this.endDate,
    this.minOrderAmount,
    required this.isActive,
  });

  bool get isValid {
    final now = DateTime.now();
    if (!isActive) return false;
    if (startDate != null && now.isBefore(startDate!)) return false;
    if (endDate != null && now.isAfter(endDate!)) return false;
    if (startDate != null && endDate != null && startDate!.isAfter(endDate!)) return false;
    return true;
  }

  bool get isFutureValid {
    final now = DateTime.now();
    if (!isActive) return false;
    if (endDate != null && now.isAfter(endDate!)) return false;
    if (startDate != null && endDate != null && startDate!.isAfter(endDate!)) return false;
    return true;
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
    
    return null; // No validation errors
  }

  bool isApplicableForOrder(double orderAmount) {
    if (!isValid) return false;
    if (minOrderAmount != null && orderAmount < minOrderAmount!) return false;
    return true;
  }

  bool willBeApplicableForOrder(double orderAmount, DateTime checkDate) {
    if (!isActive) return false;
    if (startDate != null && checkDate.isBefore(startDate!)) return false;
    if (endDate != null && checkDate.isAfter(endDate!)) return false;
    if (minOrderAmount != null && orderAmount < minOrderAmount!) return false;
    return true;
  }

  double calculateDiscount(double orderAmount) {
    if (!isValid || minOrderAmount != null && orderAmount < minOrderAmount!) {
      return 0.0;
    }

    if (type == 'percentage') {
      return orderAmount * (value / 100);
    } else if (type == 'fixed') {
      return value;
    }
    return 0.0;
  }

  double getDiscountedAmount(double orderAmount) {
    final discount = calculateDiscount(orderAmount);
    return orderAmount - discount;
  }

  DiscountEntity copyWith({
    String? discountId,
    String? vendorId,
    String? type,
    double? value,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    double? minOrderAmount,
    bool? isActive,
  }) {
    return DiscountEntity(
      discountId: discountId ?? this.discountId,
      vendorId: vendorId ?? this.vendorId,
      type: type ?? this.type,
      value: value ?? this.value,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      minOrderAmount: minOrderAmount ?? this.minOrderAmount,
      isActive: isActive ?? this.isActive,
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
    ];
  }
}
