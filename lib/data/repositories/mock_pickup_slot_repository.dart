import 'package:campus_food_app/data/datasources/mock_data_source.dart';
import 'package:campus_food_app/data/models/pickup_slot_model.dart';
import 'package:campus_food_app/domain/entities/pickup_slot_entity.dart';
import 'package:campus_food_app/domain/repositories/pickup_slot_repository.dart';

class MockPickupSlotRepository implements PickupSlotRepository {
  @override
  Future<List<PickupSlotEntity>> getPickupSlotsByVendor(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final slots = MockDataSource.getPickupSlotsByVendor(vendorId);
    return slots.map((slot) => PickupSlotEntity(
      slotId: slot.slotId,
      vendorId: slot.vendorId,
      startTime: slot.startTime,
      endTime: slot.endTime,
      maxCapacity: slot.maxCapacity,
      currentBookings: slot.currentBookings,
      preparationTime: slot.preparationTime,
      isActive: slot.isActive,
    )).toList();
  }

  @override
  Future<PickupSlotEntity?> getPickupSlotById(String slotId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      final slot = MockDataSource.pickupSlots.firstWhere((s) => s.slotId == slotId);
      return PickupSlotEntity(
        slotId: slot.slotId,
        vendorId: slot.vendorId,
        startTime: slot.startTime,
        endTime: slot.endTime,
        maxCapacity: slot.maxCapacity,
        currentBookings: slot.currentBookings,
        preparationTime: slot.preparationTime,
        isActive: slot.isActive,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<PickupSlotEntity> addPickupSlot(PickupSlotEntity pickupSlot) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final newSlot = PickupSlotModel(
      slotId: 'slot_${MockDataSource.pickupSlots.length + 1}',
      vendorId: pickupSlot.vendorId,
      startTime: pickupSlot.startTime,
      endTime: pickupSlot.endTime,
      maxCapacity: pickupSlot.maxCapacity,
      currentBookings: pickupSlot.currentBookings,
      preparationTime: pickupSlot.preparationTime,
      isActive: pickupSlot.isActive,
    );
    
    MockDataSource.pickupSlots.add(newSlot);
    
    return PickupSlotEntity(
      slotId: newSlot.slotId,
      vendorId: newSlot.vendorId,
      startTime: newSlot.startTime,
      endTime: newSlot.endTime,
      maxCapacity: newSlot.maxCapacity,
      currentBookings: newSlot.currentBookings,
      preparationTime: newSlot.preparationTime,
      isActive: newSlot.isActive,
    );
  }

  @override
  Future<PickupSlotEntity> updatePickupSlot(PickupSlotEntity pickupSlot) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.pickupSlots.indexWhere((s) => s.slotId == pickupSlot.slotId);
    if (index != -1) {
      final updatedSlot = MockDataSource.pickupSlots[index].copyWith(
        startTime: pickupSlot.startTime,
        endTime: pickupSlot.endTime,
        maxCapacity: pickupSlot.maxCapacity,
        currentBookings: pickupSlot.currentBookings,
        preparationTime: pickupSlot.preparationTime,
        isActive: pickupSlot.isActive,
      );
      
      MockDataSource.pickupSlots[index] = updatedSlot;
      
      return PickupSlotEntity(
        slotId: updatedSlot.slotId,
        vendorId: updatedSlot.vendorId,
        startTime: updatedSlot.startTime,
        endTime: updatedSlot.endTime,
        maxCapacity: updatedSlot.maxCapacity,
        currentBookings: updatedSlot.currentBookings,
        preparationTime: updatedSlot.preparationTime,
        isActive: updatedSlot.isActive,
      );
    }
    
    throw Exception('Pickup slot not found');
  }

  @override
  Future<bool> deletePickupSlot(String slotId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final index = MockDataSource.pickupSlots.indexWhere((s) => s.slotId == slotId);
    if (index != -1) {
      MockDataSource.pickupSlots.removeAt(index);
      return true;
    }
    
    return false;
  }

  @override
  Future<List<PickupSlotEntity>> getAvailableSlots(String vendorId, DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 250));
    
    final allSlots = await getPickupSlotsByVendor(vendorId);
    return allSlots.where((slot) => 
      slot.isActive && 
      slot.isAvailable &&
      _isSameDay(slot.startTime, date)
    ).toList();
  }

  @override
  Future<bool> bookSlot(String slotId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final index = MockDataSource.pickupSlots.indexWhere((s) => s.slotId == slotId);
    if (index != -1) {
      final slot = MockDataSource.pickupSlots[index];
      if (slot.currentBookings < slot.maxCapacity) {
        final updatedSlot = slot.copyWith(
          currentBookings: slot.currentBookings + 1,
        );
        MockDataSource.pickupSlots[index] = updatedSlot;
        return true;
      }
    }
    
    return false;
  }

  @override
  Future<bool> cancelSlotBooking(String slotId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final index = MockDataSource.pickupSlots.indexWhere((s) => s.slotId == slotId);
    if (index != -1) {
      final slot = MockDataSource.pickupSlots[index];
      if (slot.currentBookings > 0) {
        final updatedSlot = slot.copyWith(
          currentBookings: slot.currentBookings - 1,
        );
        MockDataSource.pickupSlots[index] = updatedSlot;
        return true;
      }
    }
    
    return false;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }
}
