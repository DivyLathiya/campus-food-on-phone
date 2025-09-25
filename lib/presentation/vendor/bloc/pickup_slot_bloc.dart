import 'package:bloc/bloc.dart';
import 'package:campus_food_app/domain/entities/pickup_slot_entity.dart';
import 'package:campus_food_app/domain/repositories/pickup_slot_repository.dart';
import 'package:equatable/equatable.dart';

part 'pickup_slot_event.dart';
part 'pickup_slot_state.dart';

class PickupSlotBloc extends Bloc<PickupSlotEvent, PickupSlotState> {
  final PickupSlotRepository pickupSlotRepository;

  PickupSlotBloc({required this.pickupSlotRepository}) : super(PickupSlotInitial()) {
    on<LoadPickupSlots>(_onLoadPickupSlots);
    on<AddPickupSlot>(_onAddPickupSlot);
    on<UpdatePickupSlot>(_onUpdatePickupSlot);
    on<DeletePickupSlot>(_onDeletePickupSlot);
    on<TogglePickupSlotStatus>(_onTogglePickupSlotStatus);
  }

  Future<void> _onLoadPickupSlots(
    LoadPickupSlots event,
    Emitter<PickupSlotState> emit,
  ) async {
    emit(PickupSlotLoading());
    try {
      final pickupSlots = await pickupSlotRepository.getPickupSlotsByVendor(event.vendorId);
      emit(PickupSlotsLoaded(pickupSlots: pickupSlots));
    } catch (e) {
      emit(PickupSlotError(message: 'Failed to load pickup slots: ${e.toString()}'));
    }
  }

  Future<void> _onAddPickupSlot(
    AddPickupSlot event,
    Emitter<PickupSlotState> emit,
  ) async {
    try {
      final newSlot = PickupSlotEntity(
        slotId: '',
        vendorId: event.vendorId,
        startTime: event.startTime,
        endTime: event.endTime,
        maxCapacity: event.maxCapacity,
        currentBookings: 0,
        preparationTime: event.preparationTime,
        isActive: event.isActive,
      );

      await pickupSlotRepository.addPickupSlot(newSlot);
      final updatedSlots = await pickupSlotRepository.getPickupSlotsByVendor(event.vendorId);
      
      emit(PickupSlotOperationSuccess(
        message: 'Pickup slot added successfully',
        pickupSlots: updatedSlots,
      ));
    } catch (e) {
      emit(PickupSlotError(message: 'Failed to add pickup slot: ${e.toString()}'));
    }
  }

  Future<void> _onUpdatePickupSlot(
    UpdatePickupSlot event,
    Emitter<PickupSlotState> emit,
  ) async {
    try {
      final existingSlot = await pickupSlotRepository.getPickupSlotById(event.slotId);
      if (existingSlot != null) {
        final updatedSlot = PickupSlotEntity(
          slotId: event.slotId,
          vendorId: existingSlot.vendorId,
          startTime: event.startTime,
          endTime: event.endTime,
          maxCapacity: event.maxCapacity,
          currentBookings: existingSlot.currentBookings,
          preparationTime: event.preparationTime,
          isActive: event.isActive,
        );

        await pickupSlotRepository.updatePickupSlot(updatedSlot);
        final updatedSlots = await pickupSlotRepository.getPickupSlotsByVendor(existingSlot.vendorId);
        
        emit(PickupSlotOperationSuccess(
          message: 'Pickup slot updated successfully',
          pickupSlots: updatedSlots,
        ));
      } else {
        emit(const PickupSlotError(message: 'Pickup slot not found'));
      }
    } catch (e) {
      emit(PickupSlotError(message: 'Failed to update pickup slot: ${e.toString()}'));
    }
  }

  Future<void> _onDeletePickupSlot(
    DeletePickupSlot event,
    Emitter<PickupSlotState> emit,
  ) async {
    try {
      final existingSlot = await pickupSlotRepository.getPickupSlotById(event.slotId);
      if (existingSlot != null) {
        await pickupSlotRepository.deletePickupSlot(event.slotId);
        final updatedSlots = await pickupSlotRepository.getPickupSlotsByVendor(existingSlot.vendorId);
        
        emit(PickupSlotOperationSuccess(
          message: 'Pickup slot deleted successfully',
          pickupSlots: updatedSlots,
        ));
      } else {
        emit(const PickupSlotError(message: 'Pickup slot not found'));
      }
    } catch (e) {
      emit(PickupSlotError(message: 'Failed to delete pickup slot: ${e.toString()}'));
    }
  }

  Future<void> _onTogglePickupSlotStatus(
    TogglePickupSlotStatus event,
    Emitter<PickupSlotState> emit,
  ) async {
    try {
      final existingSlot = await pickupSlotRepository.getPickupSlotById(event.slotId);
      if (existingSlot != null) {
        final updatedSlot = PickupSlotEntity(
          slotId: event.slotId,
          vendorId: existingSlot.vendorId,
          startTime: existingSlot.startTime,
          endTime: existingSlot.endTime,
          maxCapacity: existingSlot.maxCapacity,
          currentBookings: existingSlot.currentBookings,
          preparationTime: existingSlot.preparationTime,
          isActive: event.isActive,
        );

        await pickupSlotRepository.updatePickupSlot(updatedSlot);
        final updatedSlots = await pickupSlotRepository.getPickupSlotsByVendor(existingSlot.vendorId);
        
        emit(PickupSlotOperationSuccess(
          message: 'Pickup slot status updated successfully',
          pickupSlots: updatedSlots,
        ));
      } else {
        emit(const PickupSlotError(message: 'Pickup slot not found'));
      }
    } catch (e) {
      emit(PickupSlotError(message: 'Failed to toggle pickup slot status: ${e.toString()}'));
    }
  }
}
