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
  
  // Queue optimization methods
  Future<PickupSlotEntity> optimizeQueue(String slotId);
  Future<List<PickupSlotEntity>> getOptimalSlotsForOrder(String vendorId, DateTime preferredTime, int orderSize);
  Future<bool> addToQueue(String slotId, String orderId);
  Future<bool> removeFromQueue(String slotId, String orderId);
  Future<bool> redistributeOrders(String vendorId);
  Future<Map<String, dynamic>> getQueueAnalytics(String vendorId);
}
