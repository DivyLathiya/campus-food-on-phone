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

  @override
  Future<PickupSlotEntity> optimizeQueue(String slotId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = MockDataSource.pickupSlots.indexWhere((s) => s.slotId == slotId);
    if (index != -1) {
      final slot = MockDataSource.pickupSlots[index];
      
      // Simulate queue optimization by redistributing orders
      // In a real implementation, this would involve complex algorithms
      final optimizedSlot = slot.copyWith(
        currentBookings: (slot.currentBookings * 0.8).round(), // Simulate 20% efficiency improvement
        isPeakHour: slot.isPeakHour,
        peakHourMultiplier: slot.peakHourMultiplier,
        queuedOrderIds: slot.queuedOrderIds,
      );
      
      MockDataSource.pickupSlots[index] = optimizedSlot;
      
      return PickupSlotEntity(
        slotId: optimizedSlot.slotId,
        vendorId: optimizedSlot.vendorId,
        startTime: optimizedSlot.startTime,
        endTime: optimizedSlot.endTime,
        maxCapacity: optimizedSlot.maxCapacity,
        currentBookings: optimizedSlot.currentBookings,
        preparationTime: optimizedSlot.preparationTime,
        isActive: optimizedSlot.isActive,
      );
    }
    
    throw Exception('Pickup slot not found');
  }

  @override
  Future<List<PickupSlotEntity>> getOptimalSlotsForOrder(String vendorId, DateTime preferredTime, int orderSize) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final allSlots = await getPickupSlotsByVendor(vendorId);
    
    // Filter slots that can accommodate the order
    final suitableSlots = allSlots.where((slot) => 
      slot.isActive && 
      slot.canAcceptMoreOrders &&
      _isSameDay(slot.startTime, preferredTime)
    ).toList();
    
    // Sort by proximity to preferred time and availability
    suitableSlots.sort((a, b) {
      final timeDiffA = a.startTime.difference(preferredTime).abs().inMinutes;
      final timeDiffB = b.startTime.difference(preferredTime).abs().inMinutes;
      
      if (timeDiffA != timeDiffB) {
        return timeDiffA.compareTo(timeDiffB);
      }
      
      // Prefer slots with more availability
      return b.effectiveAvailableSlots.compareTo(a.effectiveAvailableSlots);
    });
    
    return suitableSlots.take(3).toList(); // Return top 3 optimal slots
  }

  @override
  Future<bool> addToQueue(String slotId, String orderId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final index = MockDataSource.pickupSlots.indexWhere((s) => s.slotId == slotId);
    if (index != -1) {
      final slot = MockDataSource.pickupSlots[index];
      
      // Add to queue if slot is at capacity
      if (slot.currentBookings >= slot.maxCapacity) {
        final updatedQueuedOrders = List<String>.from(slot.queuedOrderIds);
        updatedQueuedOrders.add(orderId);
        
        final updatedSlot = slot.copyWith(
          queuedOrderIds: updatedQueuedOrders,
          isPeakHour: slot.isPeakHour,
          peakHourMultiplier: slot.peakHourMultiplier,
        );
        
        MockDataSource.pickupSlots[index] = updatedSlot;
        return true;
      }
    }
    
    return false;
  }

  @override
  Future<bool> removeFromQueue(String slotId, String orderId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final index = MockDataSource.pickupSlots.indexWhere((s) => s.slotId == slotId);
    if (index != -1) {
      final slot = MockDataSource.pickupSlots[index];
      
      if (slot.queuedOrderIds.contains(orderId)) {
        final updatedQueuedOrders = List<String>.from(slot.queuedOrderIds);
        updatedQueuedOrders.remove(orderId);
        
        final updatedSlot = slot.copyWith(
          queuedOrderIds: updatedQueuedOrders,
          isPeakHour: slot.isPeakHour,
          peakHourMultiplier: slot.peakHourMultiplier,
        );
        
        MockDataSource.pickupSlots[index] = updatedSlot;
        return true;
      }
    }
    
    return false;
  }

  @override
  Future<bool> redistributeOrders(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final allSlots = await getPickupSlotsByVendor(vendorId);
    
    // Simulate order redistribution across slots
    for (int i = 0; i < allSlots.length; i++) {
      final slot = allSlots[i];
      
      // If slot is overloaded, redistribute some orders
      if (slot.currentBookings > slot.effectiveCapacity) {
        final overload = slot.currentBookings - slot.effectiveCapacity;
        final newBookings = slot.effectiveCapacity;
        
        final updatedSlot = MockDataSource.pickupSlots[i].copyWith(
          currentBookings: newBookings,
          isPeakHour: slot.isPeakHour,
          peakHourMultiplier: slot.peakHourMultiplier,
          queuedOrderIds: slot.queuedOrderIds,
        );
        
        MockDataSource.pickupSlots[i] = updatedSlot;
        
        // Find nearby slots to redistribute to
        for (int j = 0; j < allSlots.length; j++) {
          if (i != j && allSlots[j].canAcceptMoreOrders) {
            final targetSlot = MockDataSource.pickupSlots[j];
            final redistributedAmount = overload ~/ (allSlots.length - 1);
            
            final updatedTargetSlot = targetSlot.copyWith(
              currentBookings: targetSlot.currentBookings + redistributedAmount,
              isPeakHour: targetSlot.isPeakHour,
              peakHourMultiplier: targetSlot.peakHourMultiplier,
              queuedOrderIds: targetSlot.queuedOrderIds,
            );
            
            MockDataSource.pickupSlots[j] = updatedTargetSlot;
            break;
          }
        }
      }
    }
    
    return true;
  }

  @override
  Future<Map<String, dynamic>> getQueueAnalytics(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final allSlots = await getPickupSlotsByVendor(vendorId);
    
    int totalOrders = 0;
    int totalCapacity = 0;
    int totalQueuedOrders = 0;
    int peakHourSlots = 0;
    int congestedSlots = 0;
    
    for (final slot in allSlots) {
      totalOrders += slot.currentBookings;
      totalCapacity += slot.effectiveCapacity;
      totalQueuedOrders += slot.queueLength;
      
      if (slot.isPeakHour) peakHourSlots++;
      if (slot.congestionLevel == 'High' || slot.congestionLevel == 'Very High') {
        congestedSlots++;
      }
    }
    
    final utilizationRate = totalCapacity > 0 ? (totalOrders / totalCapacity * 100) : 0;
    final avgWaitTime = allSlots.isNotEmpty 
        ? allSlots.fold(0, (sum, slot) => sum + slot.estimatedWaitTime.inMinutes) / allSlots.length 
        : 0;
    
    return {
      'totalOrders': totalOrders,
      'totalCapacity': totalCapacity,
      'utilizationRate': utilizationRate.roundToDouble(),
      'totalQueuedOrders': totalQueuedOrders,
      'peakHourSlots': peakHourSlots,
      'congestedSlots': congestedSlots,
      'averageWaitTime': avgWaitTime.roundToDouble(),
      'queueEfficiency': totalQueuedOrders > 0 ? (totalOrders / (totalOrders + totalQueuedOrders) * 100) : 100,
    };
  }
}
