import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:campus_food_app/domain/entities/pickup_slot_entity.dart';
import 'package:campus_food_app/presentation/vendor/bloc/pickup_slot_bloc.dart';
import 'package:campus_food_app/core/utils/app_theme.dart';

class PickupSlotScreen extends StatefulWidget {
  final String vendorId;

  const PickupSlotScreen({
    Key? key,
    required this.vendorId,
  }) : super(key: key);

  @override
  _PickupSlotScreenState createState() => _PickupSlotScreenState();
}

class _PickupSlotScreenState extends State<PickupSlotScreen> {
  DateTime _selectedDate = DateTime.now();
  PickupSlotEntity? _selectedSlot;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedSlot = null;
      });
      // Load slots for the selected date
      context.read<PickupSlotBloc>().add(LoadPickupSlots(vendorId: widget.vendorId));
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<PickupSlotBloc>().add(LoadPickupSlots(vendorId: widget.vendorId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Pickup Slot'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Column(
        children: [
          // Date Selection
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: InkWell(
              onTap: () => _selectDate(context),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: AppTheme.primaryColor),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selected Date',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          DateFormat.yMMMd().format(_selectedDate),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          
          // Available Slots
          Expanded(
            child: BlocBuilder<PickupSlotBloc, PickupSlotState>(
              builder: (context, state) {
                if (state is PickupSlotLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PickupSlotsLoaded) {
                  final availableSlots = state.pickupSlots.where((slot) => 
                    slot.startTime.day == _selectedDate.day &&
                    slot.startTime.month == _selectedDate.month &&
                    slot.startTime.year == _selectedDate.year &&
                    slot.canAcceptMoreOrders
                  ).toList();

                  if (availableSlots.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event_busy, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'No available slots for selected date',
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try selecting a different date',
                            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: availableSlots.length,
                    itemBuilder: (context, index) {
                      final slot = availableSlots[index];
                      final isSelected = _selectedSlot?.slotId == slot.slotId;
                      
                      return _buildSlotCard(slot, isSelected);
                    },
                  );
                } else if (state is PickupSlotError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 64, color: Colors.red[400]),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<PickupSlotBloc>().add(LoadPickupSlots(vendorId: widget.vendorId));
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(child: Text('No pickup slots available'));
              },
            ),
          ),
          
          // Confirm Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedSlot != null
                    ? () {
                        Navigator.of(context).pop(_selectedSlot);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Confirm Pickup Slot',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlotCard(PickupSlotEntity slot, bool isSelected) {
    final timeFormat = DateFormat.jm();
    final congestionColor = Color(int.parse(slot.congestionColor.replaceFirst('#', '0xFF')));
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: slot.canAcceptMoreOrders
            ? () {
                setState(() {
                  _selectedSlot = slot;
                });
              }
            : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time and Peak Hour Badge
              Row(
                children: [
                  Text(
                    '${timeFormat.format(slot.startTime)} - ${timeFormat.format(slot.endTime)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (slot.isDuringPeakHours) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'PEAK',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Capacity Information
              Row(
                children: [
                  // Capacity Bar
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Capacity',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '${slot.currentBookings}/${slot.effectiveCapacity}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: congestionColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: slot.currentBookings / slot.effectiveCapacity,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(congestionColor),
                          minHeight: 6,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Congestion Level
                  Column(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: congestionColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        slot.congestionLevel,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: congestionColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              if (slot.hasQueue) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.orange[700]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${slot.queueLength} orders in queue • Est. wait: ${slot.estimatedWaitTime.inMinutes} min',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              if (slot.isDuringPeakHours) ...[
                const SizedBox(height: 8),
                Text(
                  'Peak hour: Capacity reduced to prevent congestion',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.orange[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
