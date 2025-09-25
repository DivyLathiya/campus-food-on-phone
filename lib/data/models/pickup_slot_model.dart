import 'package:campus_food_app/domain/entities/pickup_slot_entity.dart';

class PickupSlotModel {
  final String slotId;
  final String vendorId;
  final DateTime startTime;
  final DateTime endTime;
  final int maxCapacity;
  final int currentBookings;
  final int preparationTime;
  final bool isActive;
  final bool isPeakHour;
  final int peakHourMultiplier;
  final List<String> queuedOrderIds;

  PickupSlotModel({
    required this.slotId,
    required this.vendorId,
    required this.startTime,
    required this.endTime,
    required this.maxCapacity,
    required this.currentBookings,
    required this.preparationTime,
    required this.isActive,
    this.isPeakHour = false,
    this.peakHourMultiplier = 1,
    this.queuedOrderIds = const [],
  });

  factory PickupSlotModel.fromEntity(PickupSlotEntity entity) {
    return PickupSlotModel(
      slotId: entity.slotId,
      vendorId: entity.vendorId,
      startTime: entity.startTime,
      endTime: entity.endTime,
      maxCapacity: entity.maxCapacity,
      currentBookings: entity.currentBookings,
      preparationTime: entity.preparationTime,
      isActive: entity.isActive,
      isPeakHour: entity.isPeakHour,
      peakHourMultiplier: entity.peakHourMultiplier,
      queuedOrderIds: entity.queuedOrderIds,
    );
  }

  PickupSlotEntity toEntity() {
    return PickupSlotEntity(
      slotId: slotId,
      vendorId: vendorId,
      startTime: startTime,
      endTime: endTime,
      maxCapacity: maxCapacity,
      currentBookings: currentBookings,
      preparationTime: preparationTime,
      isActive: isActive,
      isPeakHour: isPeakHour,
      peakHourMultiplier: peakHourMultiplier,
      queuedOrderIds: queuedOrderIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slotId': slotId,
      'vendorId': vendorId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'maxCapacity': maxCapacity,
      'currentBookings': currentBookings,
      'preparationTime': preparationTime,
      'isActive': isActive,
      'isPeakHour': isPeakHour,
      'peakHourMultiplier': peakHourMultiplier,
      'queuedOrderIds': queuedOrderIds,
    };
  }

  factory PickupSlotModel.fromJson(Map<String, dynamic> json) {
    return PickupSlotModel(
      slotId: json['slotId'],
      vendorId: json['vendorId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      maxCapacity: json['maxCapacity'],
      currentBookings: json['currentBookings'],
      preparationTime: json['preparationTime'],
      isActive: json['isActive'],
      isPeakHour: json['isPeakHour'] ?? false,
      peakHourMultiplier: json['peakHourMultiplier'] ?? 1,
      queuedOrderIds: List<String>.from(json['queuedOrderIds'] ?? []),
    );
  }

  PickupSlotModel copyWith({
    String? slotId,
    String? vendorId,
    DateTime? startTime,
    DateTime? endTime,
    int? maxCapacity,
    int? currentBookings,
    int? preparationTime,
    bool? isActive,
    bool? isPeakHour,
    int? peakHourMultiplier,
    List<String>? queuedOrderIds,
  }) {
    return PickupSlotModel(
      slotId: slotId ?? this.slotId,
      vendorId: vendorId ?? this.vendorId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      currentBookings: currentBookings ?? this.currentBookings,
      preparationTime: preparationTime ?? this.preparationTime,
      isActive: isActive ?? this.isActive,
      isPeakHour: isPeakHour ?? this.isPeakHour,
      peakHourMultiplier: peakHourMultiplier ?? this.peakHourMultiplier,
      queuedOrderIds: queuedOrderIds ?? this.queuedOrderIds,
    );
  }
}
