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
  final bool isPeakHour;
  final int peakHourMultiplier;
  final List<String> queuedOrderIds;

  const PickupSlotEntity({
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

  int get availableSlots => maxCapacity - currentBookings;
  bool get isAvailable => isActive && availableSlots > 0;
  int get effectiveCapacity => isPeakHour ? (maxCapacity ~/ peakHourMultiplier) : maxCapacity;
  int get effectiveAvailableSlots => effectiveCapacity - currentBookings;
  bool get canAcceptMoreOrders => isActive && effectiveAvailableSlots > 0;
  int get queueLength => queuedOrderIds.length;
  bool get hasQueue => queuedOrderIds.isNotEmpty;
  
  // Calculate estimated wait time based on queue and preparation time
  Duration get estimatedWaitTime {
    if (!hasQueue) return Duration.zero;
    return Duration(minutes: queueLength * preparationTime);
  }
  
  // Check if slot is within peak hours (12-2 PM and 6-8 PM)
  bool get isDuringPeakHours {
    final hour = startTime.hour;
    return (hour >= 12 && hour < 14) || (hour >= 18 && hour < 20);
  }
  
  // Get congestion level for UI display
  String get congestionLevel {
    final capacityRatio = currentBookings / effectiveCapacity;
    if (capacityRatio >= 0.9) return 'Very High';
    if (capacityRatio >= 0.7) return 'High';
    if (capacityRatio >= 0.5) return 'Medium';
    if (capacityRatio > 0) return 'Low';
    return 'Empty';
  }
  
  // Get color for congestion level
  String get congestionColor {
    final level = congestionLevel;
    if (level == 'Very High') return '#D32F2F';
    if (level == 'High') return '#F57C00';
    if (level == 'Medium') return '#FBC02D';
    if (level == 'Low') return '#689F38';
    return '#1976D2';
  }

  PickupSlotEntity copyWith({
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
    return PickupSlotEntity(
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
      isPeakHour,
      peakHourMultiplier,
      queuedOrderIds,
    ];
  }
}
