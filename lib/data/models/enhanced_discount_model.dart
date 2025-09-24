import 'package:campus_food_app/domain/entities/enhanced_discount_entity.dart';

class EnhancedDiscountModel {
  final String discountId;
  final String vendorId;
  final String title;
  final String description;
  final String type; // 'percentage', 'fixed', 'combo', 'happy_hour'
  final double value;
  final double? minOrderAmount;
  final DateTime? startDate;
  final DateTime? endDate;
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
  
  final DateTime createdAt;
  final DateTime updatedAt;

  EnhancedDiscountModel({
    required this.discountId,
    required this.vendorId,
    required this.title,
    required this.description,
    required this.type,
    required this.value,
    this.minOrderAmount,
    this.startDate,
    this.endDate,
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory EnhancedDiscountModel.fromEntity(EnhancedDiscountEntity entity) {
    return EnhancedDiscountModel(
      discountId: entity.discountId,
      vendorId: entity.vendorId,
      title: '', // Entity doesn't have title, using empty string
      description: entity.description,
      type: entity.type,
      value: entity.value,
      minOrderAmount: entity.minOrderAmount,
      startDate: entity.startDate,
      endDate: entity.endDate,
      isActive: entity.isActive,
      requiredMenuItemIds: entity.requiredMenuItemIds,
      comboPrice: entity.comboPrice,
      comboName: entity.comboName,
      happyHourDays: entity.happyHourDays,
      happyHourStartTime: entity.happyHourStartTime,
      happyHourEndTime: entity.happyHourEndTime,
      happyHourDiscountRate: entity.happyHourDiscountRate,
      maxUsageCount: entity.maxUsageCount,
      currentUsageCount: entity.currentUsageCount,
      applicableCategories: entity.applicableCategories,
      createdAt: DateTime.now(), // Entity doesn't have createdAt, using current time
      updatedAt: DateTime.now(), // Entity doesn't have updatedAt, using current time
    );
  }

  EnhancedDiscountEntity toEntity() {
    return EnhancedDiscountEntity(
      discountId: discountId,
      vendorId: vendorId,
      type: type,
      value: value,
      description: description,
      startDate: startDate,
      endDate: endDate,
      minOrderAmount: minOrderAmount,
      isActive: isActive,
      requiredMenuItemIds: requiredMenuItemIds,
      comboPrice: comboPrice,
      comboName: comboName,
      happyHourDays: happyHourDays,
      happyHourStartTime: happyHourStartTime,
      happyHourEndTime: happyHourEndTime,
      happyHourDiscountRate: happyHourDiscountRate,
      maxUsageCount: maxUsageCount,
      currentUsageCount: currentUsageCount,
      applicableCategories: applicableCategories,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'discountId': discountId,
      'vendorId': vendorId,
      'title': title,
      'description': description,
      'type': type,
      'value': value,
      'minOrderAmount': minOrderAmount,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isActive': isActive,
      'requiredMenuItemIds': requiredMenuItemIds,
      'comboPrice': comboPrice,
      'comboName': comboName,
      'happyHourDays': happyHourDays,
      'happyHourStartTime': happyHourStartTime != null ? '${happyHourStartTime!.hour}:${happyHourStartTime!.minute}' : null,
      'happyHourEndTime': happyHourEndTime != null ? '${happyHourEndTime!.hour}:${happyHourEndTime!.minute}' : null,
      'happyHourDiscountRate': happyHourDiscountRate,
      'maxUsageCount': maxUsageCount,
      'currentUsageCount': currentUsageCount,
      'applicableCategories': applicableCategories,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory EnhancedDiscountModel.fromJson(Map<String, dynamic> json) {
    TimeOfDay? parseTimeOfDay(String? timeString) {
      if (timeString == null) return null;
      final parts = timeString.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }

    return EnhancedDiscountModel(
      discountId: json['discountId'],
      vendorId: json['vendorId'],
      title: json['title'] ?? '',
      description: json['description'],
      type: json['type'],
      value: json['value'].toDouble(),
      minOrderAmount: json['minOrderAmount']?.toDouble(),
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isActive: json['isActive'],
      requiredMenuItemIds: json['requiredMenuItemIds']?.cast<String>(),
      comboPrice: json['comboPrice']?.toDouble(),
      comboName: json['comboName'],
      happyHourDays: json['happyHourDays']?.cast<int>(),
      happyHourStartTime: parseTimeOfDay(json['happyHourStartTime']),
      happyHourEndTime: parseTimeOfDay(json['happyHourEndTime']),
      happyHourDiscountRate: json['happyHourDiscountRate']?.toDouble(),
      maxUsageCount: json['maxUsageCount'],
      currentUsageCount: json['currentUsageCount'],
      applicableCategories: json['applicableCategories']?.cast<String>(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  EnhancedDiscountModel copyWith({
    String? discountId,
    String? vendorId,
    String? title,
    String? description,
    String? type,
    double? value,
    double? minOrderAmount,
    DateTime? startDate,
    DateTime? endDate,
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
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EnhancedDiscountModel(
      discountId: discountId ?? this.discountId,
      vendorId: vendorId ?? this.vendorId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      value: value ?? this.value,
      minOrderAmount: minOrderAmount ?? this.minOrderAmount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
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
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
