part of 'pickup_slot_bloc.dart';

abstract class PickupSlotEvent extends Equatable {
  const PickupSlotEvent();

  @override
  List<Object> get props => [];
}

class LoadPickupSlots extends PickupSlotEvent {
  final String vendorId;

  const LoadPickupSlots({required this.vendorId});

  @override
  List<Object> get props => [vendorId];
}

class AddPickupSlot extends PickupSlotEvent {
  final String vendorId;
  final DateTime startTime;
  final DateTime endTime;
  final int maxCapacity;
  final int preparationTime;
  final bool isActive;

  const AddPickupSlot({
    required this.vendorId,
    required this.startTime,
    required this.endTime,
    required this.maxCapacity,
    required this.preparationTime,
    required this.isActive,
  });

  @override
  List<Object> get props => [
        vendorId,
        startTime,
        endTime,
        maxCapacity,
        preparationTime,
        isActive,
      ];
}

class UpdatePickupSlot extends PickupSlotEvent {
  final String slotId;
  final DateTime startTime;
  final DateTime endTime;
  final int maxCapacity;
  final int preparationTime;
  final bool isActive;

  const UpdatePickupSlot({
    required this.slotId,
    required this.startTime,
    required this.endTime,
    required this.maxCapacity,
    required this.preparationTime,
    required this.isActive,
  });

  @override
  List<Object> get props => [
        slotId,
        startTime,
        endTime,
        maxCapacity,
        preparationTime,
        isActive,
      ];
}

class DeletePickupSlot extends PickupSlotEvent {
  final String slotId;

  const DeletePickupSlot({required this.slotId});

  @override
  List<Object> get props => [slotId];
}

class TogglePickupSlotStatus extends PickupSlotEvent {
  final String slotId;
  final bool isActive;

  const TogglePickupSlotStatus({
    required this.slotId,
    required this.isActive,
  });

  @override
  List<Object> get props => [slotId, isActive];
}
