import 'package:campus_food_app/domain/entities/pickup_slot_entity.dart';

abstract class PickupSlotRepository {
  Future<List<PickupSlotEntity>> getPickupSlotsByVendor(String vendorId);
  Future<PickupSlotEntity?> getPickupSlotById(String slotId);
  Future<PickupSlotEntity> addPickupSlot(PickupSlotEntity pickupSlot);
  Future<PickupSlotEntity> updatePickupSlot(PickupSlotEntity pickupSlot);
  Future<bool> deletePickupSlot(String slotId);
  Future<List<PickupSlotEntity>> getAvailableSlots(String vendorId, DateTime date);
  Future<bool> bookSlot(String slotId);
  Future<bool> cancelSlotBooking(String slotId);
}
