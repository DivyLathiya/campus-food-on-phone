import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/presentation/student/bloc/notification_bloc.dart';
import 'package:campus_food_app/domain/entities/notification_entity.dart';
import 'package:campus_food_app/domain/entities/user_entity.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  final UserEntity user;

  const NotificationScreen({super.key, required this.user});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationType? _selectedType;
  NotificationPriority? _selectedPriority;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
    context.read<NotificationBloc>().add(
          LoadNotifications(userId: widget.user.userId),
        );
  }

  void _refreshNotifications() {
    context.read<NotificationBloc>().add(
          RefreshNotifications(userId: widget.user.userId),
        );
  }

  void _filterByType(NotificationType type) {
    setState(() {
      _selectedType = type;
      _selectedPriority = null;
    });
    context.read<NotificationBloc>().add(
          LoadNotificationsByType(
            userId: widget.user.userId,
            type: type,
          ),
        );
  }

  void _filterByPriority(NotificationPriority priority) {
    setState(() {
      _selectedPriority = priority;
      _selectedType = null;
    });
    context.read<NotificationBloc>().add(
          LoadNotificationsByPriority(
            userId: widget.user.userId,
            priority: priority,
          ),
        );
  }

  void _clearFilters() {
    setState(() {
      _selectedType = null;
      _selectedPriority = null;
    });
    _loadNotifications();
  }

  void _markAsRead(String notificationId) {
    context.read<NotificationBloc>().add(
          MarkNotificationAsRead(notificationId: notificationId),
        );
  }

  void _markAllAsRead() {
    context.read<NotificationBloc>().add(
          MarkAllNotificationsAsRead(userId: widget.user.userId),
        );
  }

  void _deleteNotification(String notificationId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Notification'),
        content: const Text('Are you sure you want to delete this notification?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<NotificationBloc>().add(
                    DeleteNotification(notificationId: notificationId),
                  );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: _markAllAsRead,
            tooltip: 'Mark all as read',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshNotifications,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                if (state is NotificationLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NotificationsLoaded) {
                  return _buildNotificationList(state.notifications, state.unreadCount);
                } else if (state is NotificationError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('No notifications'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (_selectedType != null || _selectedPriority != null)
              ActionChip(
                avatar: const Icon(Icons.clear),
                label: const Text('Clear Filters'),
                onPressed: _clearFilters,
                backgroundColor: Colors.grey[200],
              ),
            const SizedBox(width: 8),
            _buildTypeFilterChip('All', null, _selectedType == null && _selectedPriority == null),
            const SizedBox(width: 8),
            _buildTypeFilterChip('Orders', NotificationType.orderStatus, _selectedType == NotificationType.orderStatus),
            const SizedBox(width: 8),
            _buildTypeFilterChip('Promotions', NotificationType.promotionalAlert, _selectedType == NotificationType.promotionalAlert),
            const SizedBox(width: 8),
            _buildTypeFilterChip('Wallet', NotificationType.walletReminder, _selectedType == NotificationType.walletReminder),
            const SizedBox(width: 8),
            _buildTypeFilterChip('Admin', NotificationType.adminMessage, _selectedType == NotificationType.adminMessage),
            const SizedBox(width: 16),
            _buildPriorityFilterChip('Urgent', NotificationPriority.urgent, _selectedPriority == NotificationPriority.urgent),
            const SizedBox(width: 8),
            _buildPriorityFilterChip('High', NotificationPriority.high, _selectedPriority == NotificationPriority.high),
            const SizedBox(width: 8),
            _buildPriorityFilterChip('Medium', NotificationPriority.medium, _selectedPriority == NotificationPriority.medium),
            const SizedBox(width: 8),
            _buildPriorityFilterChip('Low', NotificationPriority.low, _selectedPriority == NotificationPriority.low),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeFilterChip(String label, NotificationType? type, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          _filterByType(type!);
        } else {
          _clearFilters();
        }
      },
      selectedColor: Colors.blue.withOpacity(0.2),
      checkmarkColor: Colors.blue,
    );
  }

  Widget _buildPriorityFilterChip(String label, NotificationPriority priority, bool isSelected) {
    Color color;
    switch (priority) {
      case NotificationPriority.urgent:
        color = Colors.red;
        break;
      case NotificationPriority.high:
        color = Colors.orange;
        break;
      case NotificationPriority.medium:
        color = Colors.blue;
        break;
      case NotificationPriority.low:
        color = Colors.grey;
        break;
    }

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          _filterByPriority(priority);
        } else {
          _clearFilters();
        }
      },
      selectedColor: color.withOpacity(0.2),
      checkmarkColor: color,
      avatar: isSelected ? Icon(Icons.priority_high, color: color, size: 16) : null,
    );
  }

  Widget _buildNotificationList(List<NotificationEntity> notifications, int unreadCount) {
    if (notifications.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No notifications',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        if (unreadCount > 0)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.blue.withOpacity(0.1),
            child: Text(
              '$unreadCount unread notification${unreadCount > 1 ? 's' : ''}',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => _refreshNotifications(),
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationCard(notification);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationCard(NotificationEntity notification) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: notification.isUnread ? 2 : 1,
      color: notification.isUnread ? Colors.blue.withOpacity(0.05) : null,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: notification.getPriorityColor().withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            notification.getTypeIcon(),
            color: notification.getPriorityColor(),
            size: 20,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                notification.title,
                style: TextStyle(
                  fontWeight: notification.isUnread ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (notification.priority == NotificationPriority.urgent ||
                notification.priority == NotificationPriority.high)
              Icon(
                Icons.priority_high,
                color: notification.getPriorityColor(),
                size: 16,
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: notification.isUnread ? Colors.black87 : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  _formatDateTime(notification.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: notification.getPriorityColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    notification.typeDisplay,
                    style: TextStyle(
                      fontSize: 10,
                      color: notification.getPriorityColor(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'mark_read':
                _markAsRead(notification.notificationId);
                break;
              case 'delete':
                _deleteNotification(notification.notificationId);
                break;
            }
          },
          itemBuilder: (context) => [
            if (notification.isUnread)
              const PopupMenuItem(
                value: 'mark_read',
                child: Row(
                  children: [
                    Icon(Icons.mark_email_read),
                    SizedBox(width: 8),
                    Text('Mark as read'),
                  ],
                ),
              ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          if (notification.isUnread) {
            _markAsRead(notification.notificationId);
          }
          _handleNotificationAction(notification);
        },
      ),
    );
  }

  void _handleNotificationAction(NotificationEntity notification) {
    if (notification.isActionable && notification.actionType != null) {
      switch (notification.actionType) {
        case 'view_order':
          // Navigate to order details
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigate to order details')),
          );
          break;
        case 'view_vendor':
          // Navigate to vendor menu
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigate to vendor menu')),
          );
          break;
        case 'add_funds':
          // Navigate to wallet screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigate to wallet screen')),
          );
          break;
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(dateTime);
    }
  }
}
