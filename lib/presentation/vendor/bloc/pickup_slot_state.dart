part of 'pickup_slot_bloc.dart';

abstract class PickupSlotState extends Equatable {
  const PickupSlotState();

  @override
  List<Object> get props => [];
}

class PickupSlotInitial extends PickupSlotState {}

class PickupSlotLoading extends PickupSlotState {}

class PickupSlotsLoaded extends PickupSlotState {
  final List<PickupSlotEntity> pickupSlots;

  const PickupSlotsLoaded({required this.pickupSlots});

  @override
  List<Object> get props => [pickupSlots];
}

class PickupSlotOperationSuccess extends PickupSlotState {
  final String message;
  final List<PickupSlotEntity> pickupSlots;

  const PickupSlotOperationSuccess({
    required this.message,
    required this.pickupSlots,
  });

  @override
  List<Object> get props => [message, pickupSlots];
}

class PickupSlotError extends PickupSlotState {
  final String message;

  const PickupSlotError({required this.message});

  @override
  List<Object> get props => [message];
}
