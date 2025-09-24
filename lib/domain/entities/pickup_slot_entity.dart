import 'package:equatable/equatable.dart';

class PickupSlotEntity extends Equatable {
  final String slotId;
  final String vendorId;
  final DateTime startTime;
  final DateTime endTime;
  final int maxCapacity;
  final int currentBookings;
  final int preparationTime;
  final bool isActive;

  const PickupSlotEntity({
    required this.slotId,
    required this.vendorId,
    required this.startTime,
    required this.endTime,
    required this.maxCapacity,
    required this.currentBookings,
    required this.preparationTime,
    required this.isActive,
  });

  int get availableSlots => maxCapacity - currentBookings;
  bool get isAvailable => isActive && availableSlots > 0;

  PickupSlotEntity copyWith({
    String? slotId,
    String? vendorId,
    DateTime? startTime,
    DateTime? endTime,
    int? maxCapacity,
    int? currentBookings,
    int? preparationTime,
    bool? isActive,
  }) {
    return PickupSlotEntity(
      slotId: slotId ?? this.slotId,
      vendorId: vendorId ?? this.vendorId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      currentBookings: currentBookings ?? this.currentBookings,
      preparationTime: preparationTime ?? this.preparationTime,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object> get props {
    return [
      slotId,
      vendorId,
      startTime,
      endTime,
      maxCapacity,
      currentBookings,
      preparationTime,
      isActive,
    ];
  }
}
