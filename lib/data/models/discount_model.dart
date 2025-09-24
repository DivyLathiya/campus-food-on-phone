import 'package:equatable/equatable.dart';

class DiscountModel extends Equatable {
  final String discountId;
  final String vendorId;
  final String type;
  final double value;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minOrderAmount;
  final bool isActive;

  const DiscountModel({
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

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      discountId: json['discountId'] as String,
      vendorId: json['vendorId'] as String,
      type: json['type'] as String,
      value: (json['value'] as num).toDouble(),
      description: json['description'] as String,
      startDate: json['startDate'] != null 
          ? DateTime.parse(json['startDate'] as String)
          : null,
      endDate: json['endDate'] != null 
          ? DateTime.parse(json['endDate'] as String)
          : null,
      minOrderAmount: json['minOrderAmount'] != null 
          ? (json['minOrderAmount'] as num).toDouble()
          : null,
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'discountId': discountId,
      'vendorId': vendorId,
      'type': type,
      'value': value,
      'description': description,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'minOrderAmount': minOrderAmount,
      'isActive': isActive,
    };
  }

  DiscountModel copyWith({
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
    return DiscountModel(
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
