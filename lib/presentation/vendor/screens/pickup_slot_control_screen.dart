import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/domain/entities/pickup_slot_entity.dart';
import 'package:campus_food_app/presentation/vendor/bloc/pickup_slot_bloc.dart';
import 'package:intl/intl.dart';

class PickupSlotControlScreen extends StatefulWidget {
  final String vendorId;

  const PickupSlotControlScreen({
    Key? key,
    required this.vendorId,
  }) : super(key: key);

  @override
  State<PickupSlotControlScreen> createState() => _PickupSlotControlScreenState();
}

class _PickupSlotControlScreenState extends State<PickupSlotControlScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PickupSlotBloc>().add(LoadPickupSlots(vendorId: widget.vendorId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pickup Slot Control'),
        backgroundColor: Colors.orange,
      ),
      body: BlocConsumer<PickupSlotBloc, PickupSlotState>(
        listener: (context, state) {
          if (state is PickupSlotOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is PickupSlotError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PickupSlotLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PickupSlotsLoaded || state is PickupSlotOperationSuccess) {
            final slots = state is PickupSlotsLoaded 
                ? state.pickupSlots 
                : (state as PickupSlotOperationSuccess).pickupSlots;
            
            return Column(
              children: [
                _buildSummaryCards(slots),
                Expanded(
                  child: _buildPickupSlotsList(slots),
                ),
              ],
            );
          } else if (state is PickupSlotError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
          return const Center(child: Text('No pickup slots found'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPickupSlotDialog(context),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCards(List<PickupSlotEntity> slots) {
    final totalSlots = slots.length;
    final activeSlots = slots.where((slot) => slot.isActive).length;
    final totalCapacity = slots.fold(0, (sum, slot) => sum + slot.maxCapacity);
    final totalBookings = slots.fold(0, (sum, slot) => sum + slot.currentBookings);
    final averageUtilization = totalCapacity > 0 ? (totalBookings / totalCapacity * 100).round() : 0;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Total Slots',
                  totalSlots.toString(),
                  Icons.schedule,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Active Slots',
                  activeSlots.toString(),
                  Icons.play_circle,
                  Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Total Capacity',
                  totalCapacity.toString(),
                  Icons.group,
                  Colors.purple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Utilization',
                  '$averageUtilization%',
                  Icons.trending_up,
                  Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickupSlotsList(List<PickupSlotEntity> slots) {
    if (slots.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.schedule, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No pickup slots configured',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Tap the + button to add your first pickup slot',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        return _buildPickupSlotCard(slot);
      },
    );
  }

  Widget _buildPickupSlotCard(PickupSlotEntity slot) {
    final utilizationRate = slot.maxCapacity > 0 
        ? (slot.currentBookings / slot.maxCapacity * 100).round() 
        : 0;
    
    final utilizationColor = utilizationRate >= 80 
        ? Colors.red 
        : utilizationRate >= 60 
            ? Colors.orange 
            : Colors.green;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${DateFormat('h:mm a').format(slot.startTime)} - ${DateFormat('h:mm a').format(slot.endTime)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Switch(
                  value: slot.isActive,
                  onChanged: (value) {
                    context.read<PickupSlotBloc>().add(
                      TogglePickupSlotStatus(
                        slotId: slot.slotId,
                        isActive: value,
                      ),
                    );
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildInfoChip(
                  'Capacity',
                  '${slot.currentBookings}/${slot.maxCapacity}',
                  Icons.group,
                  utilizationColor,
                ),
                const SizedBox(width: 8),
                _buildInfoChip(
                  'Prep Time',
                  '${slot.preparationTime} min',
                  Icons.timer,
                  Colors.blue,
                ),
                const SizedBox(width: 8),
                _buildInfoChip(
                  'Utilization',
                  '$utilizationRate%',
                  Icons.trending_up,
                  utilizationColor,
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: slot.maxCapacity > 0 ? slot.currentBookings / slot.maxCapacity : 0,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(utilizationColor),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () => _showEditPickupSlotDialog(context, slot),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () => _showDeleteConfirmationDialog(context, slot),
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 4),
            Column(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddPickupSlotDialog(BuildContext context) {
    final startTimeController = TextEditingController();
    final endTimeController = TextEditingController();
    final capacityController = TextEditingController();
    final prepTimeController = TextEditingController();
    bool isActive = true;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Pickup Slot'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTimeField(
                  'Start Time',
                  startTimeController,
                  (time) => startTimeController.text = time,
                ),
                const SizedBox(height: 16),
                _buildTimeField(
                  'End Time',
                  endTimeController,
                  (time) => endTimeController.text = time,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: capacityController,
                  decoration: const InputDecoration(
                    labelText: 'Max Capacity',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.group),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter capacity';
                    }
                    final capacity = int.tryParse(value);
                    if (capacity == null || capacity <= 0) {
                      return 'Please enter a valid capacity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: prepTimeController,
                  decoration: const InputDecoration(
                    labelText: 'Preparation Time (minutes)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.timer),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter preparation time';
                    }
                    final prepTime = int.tryParse(value);
                    if (prepTime == null || prepTime <= 0) {
                      return 'Please enter a valid preparation time';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Active'),
                  value: isActive,
                  onChanged: (value) {
                    setState(() {
                      isActive = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_validatePickupSlotForm(
                  startTimeController.text,
                  endTimeController.text,
                  capacityController.text,
                  prepTimeController.text,
                )) {
                  final startTime = _parseTime(startTimeController.text);
                  final endTime = _parseTime(endTimeController.text);
                  final capacity = int.parse(capacityController.text);
                  final prepTime = int.parse(prepTimeController.text);

                  context.read<PickupSlotBloc>().add(
                    AddPickupSlot(
                      vendorId: widget.vendorId,
                      startTime: startTime,
                      endTime: endTime,
                      maxCapacity: capacity,
                      preparationTime: prepTime,
                      isActive: isActive,
                    ),
                  );

                  Navigator.pop(dialogContext);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Add Slot'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditPickupSlotDialog(BuildContext context, PickupSlotEntity slot) {
    final startTimeController = TextEditingController(
      text: DateFormat('h:mm a').format(slot.startTime),
    );
    final endTimeController = TextEditingController(
      text: DateFormat('h:mm a').format(slot.endTime),
    );
    final capacityController = TextEditingController(
      text: slot.maxCapacity.toString(),
    );
    final prepTimeController = TextEditingController(
      text: slot.preparationTime.toString(),
    );
    bool isActive = slot.isActive;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Pickup Slot'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTimeField(
                  'Start Time',
                  startTimeController,
                  (time) => startTimeController.text = time,
                ),
                const SizedBox(height: 16),
                _buildTimeField(
                  'End Time',
                  endTimeController,
                  (time) => endTimeController.text = time,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: capacityController,
                  decoration: const InputDecoration(
                    labelText: 'Max Capacity',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.group),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter capacity';
                    }
                    final capacity = int.tryParse(value);
                    if (capacity == null || capacity <= 0) {
                      return 'Please enter a valid capacity';
                    }
                    if (capacity < slot.currentBookings) {
                      return 'Capacity cannot be less than current bookings';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: prepTimeController,
                  decoration: const InputDecoration(
                    labelText: 'Preparation Time (minutes)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.timer),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter preparation time';
                    }
                    final prepTime = int.tryParse(value);
                    if (prepTime == null || prepTime <= 0) {
                      return 'Please enter a valid preparation time';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Active'),
                  value: isActive,
                  onChanged: (value) {
                    setState(() {
                      isActive = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_validatePickupSlotForm(
                  startTimeController.text,
                  endTimeController.text,
                  capacityController.text,
                  prepTimeController.text,
                )) {
                  final startTime = _parseTime(startTimeController.text);
                  final endTime = _parseTime(endTimeController.text);
                  final capacity = int.parse(capacityController.text);
                  final prepTime = int.parse(prepTimeController.text);

                  context.read<PickupSlotBloc>().add(
                    UpdatePickupSlot(
                      slotId: slot.slotId,
                      startTime: startTime,
                      endTime: endTime,
                      maxCapacity: capacity,
                      preparationTime: prepTime,
                      isActive: isActive,
                    ),
                  );

                  Navigator.pop(dialogContext);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Update Slot'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, PickupSlotEntity slot) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Pickup Slot'),
        content: Text(
          'Are you sure you want to delete the pickup slot from '
          '${DateFormat('h:mm a').format(slot.startTime)} to ${DateFormat('h:mm a').format(slot.endTime)}? '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<PickupSlotBloc>().add(
                DeletePickupSlot(slotId: slot.slotId),
              );
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField(String label, TextEditingController controller, Function(String) onTimeSelected) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.access_time),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            final TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time != null) {
              final now = DateTime.now();
              final selectedTime = DateTime(
                now.year,
                now.month,
                now.day,
                time.hour,
                time.minute,
              );
              onTimeSelected(DateFormat('h:mm a').format(selectedTime));
            }
          },
        ),
      ),
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select $label';
        }
        return null;
      },
    );
  }

  bool _validatePickupSlotForm(String startTime, String endTime, String capacity, String prepTime) {
    if (startTime.isEmpty || endTime.isEmpty || capacity.isEmpty || prepTime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    final start = _parseTime(startTime);
    final end = _parseTime(endTime);
    
    if (start.isAfter(end) || start.isAtSameMomentAs(end)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('End time must be after start time'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    final capacityValue = int.tryParse(capacity);
    final prepTimeValue = int.tryParse(prepTime);
    
    if (capacityValue == null || capacityValue <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid capacity'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (prepTimeValue == null || prepTimeValue <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid preparation time'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }

  DateTime _parseTime(String timeString) {
    final format = DateFormat('h:mm a');
    final now = DateTime.now();
    final parsedTime = format.parse(timeString);
    return DateTime(
      now.year,
      now.month,
      now.day,
      parsedTime.hour,
      parsedTime.minute,
    );
  }
}
