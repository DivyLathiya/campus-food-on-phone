import 'package:campus_food_app/data/models/notification_model.dart';
import 'package:campus_food_app/domain/entities/notification_entity.dart';
import 'package:campus_food_app/domain/repositories/notification_repository.dart';

class MockNotificationRepository implements NotificationRepository {
  final List<NotificationModel> _notifications = [];

  MockNotificationRepository() {
    _initializeMockData();
  }

  void _initializeMockData() {
    // Order Status Notifications
    _notifications.add(NotificationModel.fromEntity(
      NotificationEntity.createOrderStatusNotification(
        userId: 'student1',
        orderId: 'order1',
        status: 'accepted',
        title: 'Order Accepted',
        message: 'Your order #1234 has been accepted by the vendor.',
        priority: NotificationPriority.medium,
      ),
    ));

    _notifications.add(NotificationModel.fromEntity(
      NotificationEntity.createOrderStatusNotification(
        userId: 'student1',
        orderId: 'order2',
        status: 'ready',
        title: 'Order Ready for Pickup',
        message: 'Your order #1235 is ready for pickup!',
        priority: NotificationPriority.high,
      ),
    ));

    // Promotional Alerts
    _notifications.add(NotificationModel.fromEntity(
      NotificationEntity.createPromotionalAlert(
        userId: 'student1',
        vendorId: 'vendor1',
        title: 'Happy Hour Special!',
        message: 'Get 20% off on all burgers from 2-4 PM today only!',
        priority: NotificationPriority.medium,
      ),
    ));

    _notifications.add(NotificationModel.fromEntity(
      NotificationEntity.createPromotionalAlert(
        userId: 'student1',
        vendorId: 'vendor2',
        title: 'Weekend Deal',
        message: 'Buy 1 Get 1 Free on all pizzas this weekend!',
        priority: NotificationPriority.low,
      ),
    ));

    // Wallet Reminders
    _notifications.add(NotificationModel.fromEntity(
      NotificationEntity.createWalletReminder(
        userId: 'student1',
        title: 'Low Wallet Balance',
        message: 'Your wallet balance is low. Add funds to continue ordering.',
        priority: NotificationPriority.high,
      ),
    ));

    _notifications.add(NotificationModel.fromEntity(
      NotificationEntity.createWalletReminder(
        userId: 'student1',
        title: 'Funds Added Successfully',
        message: '₹500 has been added to your wallet successfully.',
        priority: NotificationPriority.medium,
      ),
    ));

    // Admin Messages
    _notifications.add(NotificationModel.fromEntity(
      NotificationEntity.createAdminMessage(
        userId: 'student1',
        title: 'System Maintenance',
        message: 'The app will be under maintenance on Sunday 2-4 AM.',
        priority: NotificationPriority.high,
      ),
    ));

    _notifications.add(NotificationModel.fromEntity(
      NotificationEntity.createAdminMessage(
        userId: 'student1',
        title: 'New Feature Launch',
        message: 'Introducing our new loyalty program! Earn points on every order.',
        priority: NotificationPriority.medium,
      ),
    ));

    // Add some read notifications
    final orderAcceptedIndex = _notifications.indexWhere((n) => n.title == 'Order Accepted');
    if (orderAcceptedIndex != -1) {
      _notifications[orderAcceptedIndex] = _notifications[orderAcceptedIndex].copyWith(
        readAt: DateTime.now().subtract(const Duration(hours: 2)),
      );
    }
    
    final happyHourIndex = _notifications.indexWhere((n) => n.title == 'Happy Hour Special!');
    if (happyHourIndex != -1) {
      _notifications[happyHourIndex] = _notifications[happyHourIndex].copyWith(
        readAt: DateTime.now().subtract(const Duration(hours: 1)),
      );
    }
  }

  @override
  Future<List<NotificationEntity>> getUserNotifications(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _notifications
        .where((n) => n.userId == userId && n.archivedAt == null)
        .map((n) => n.toEntity())
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<List<NotificationEntity>> getNotificationsByType(String userId, NotificationType type) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _notifications
        .where((n) => n.userId == userId && n.type == type.name && n.archivedAt == null)
        .map((n) => n.toEntity())
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<List<NotificationEntity>> getUnreadNotifications(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _notifications
        .where((n) => n.userId == userId && n.status == 'unread' && n.archivedAt == null)
        .map((n) => n.toEntity())
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<NotificationEntity?> getNotificationById(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final notification = _notifications.firstWhere(
      (n) => n.notificationId == notificationId,
      orElse: () => throw Exception('Notification not found'),
    );
    return notification.toEntity();
  }

  @override
  Future<NotificationEntity> createNotification(NotificationEntity notification) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final model = NotificationModel.fromEntity(notification);
    _notifications.add(model);
    return notification;
  }

  @override
  Future<NotificationEntity> updateNotification(NotificationEntity notification) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _notifications.indexWhere((n) => n.notificationId == notification.notificationId);
    if (index == -1) {
      throw Exception('Notification not found');
    }
    _notifications[index] = NotificationModel.fromEntity(notification);
    return notification;
  }

  @override
  Future<bool> markAsRead(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _notifications.indexWhere((n) => n.notificationId == notificationId);
    if (index == -1) {
      return false;
    }
    _notifications[index] = _notifications[index].copyWith(
      status: 'read',
      readAt: DateTime.now(),
    );
    return true;
  }

  @override
  Future<bool> markAsArchived(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _notifications.indexWhere((n) => n.notificationId == notificationId);
    if (index == -1) {
      return false;
    }
    _notifications[index] = _notifications[index].copyWith(
      status: 'archived',
      archivedAt: DateTime.now(),
    );
    return true;
  }

  @override
  Future<bool> markAllAsRead(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    for (int i = 0; i < _notifications.length; i++) {
      if (_notifications[i].userId == userId && _notifications[i].status == 'unread') {
        _notifications[i] = _notifications[i].copyWith(
          status: 'read',
          readAt: DateTime.now(),
        );
      }
    }
    return true;
  }

  @override
  Future<bool> deleteNotification(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _notifications.indexWhere((n) => n.notificationId == notificationId);
    if (index == -1) {
      return false;
    }
    _notifications.removeAt(index);
    return true;
  }

  @override
  Future<int> getUnreadCount(String userId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _notifications
        .where((n) => n.userId == userId && n.status == 'unread' && n.archivedAt == null)
        .length;
  }

  @override
  Future<List<NotificationEntity>> getNotificationsByPriority(String userId, NotificationPriority priority) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _notifications
        .where((n) => n.userId == userId && n.priority == priority.name && n.archivedAt == null)
        .map((n) => n.toEntity())
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<List<NotificationEntity>> getNotificationsByDateRange(String userId, DateTime startDate, DateTime endDate) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _notifications
        .where((n) => 
            n.userId == userId && 
            n.createdAt.isAfter(startDate) && 
            n.createdAt.isBefore(endDate) && 
            n.archivedAt == null)
        .map((n) => n.toEntity())
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<bool> sendOrderStatusNotification(String userId, String orderId, String status, String title, String message) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final notification = NotificationEntity.createOrderStatusNotification(
      userId: userId,
      orderId: orderId,
      status: status,
      title: title,
      message: message,
    );
    _notifications.add(NotificationModel.fromEntity(notification));
    return true;
  }

  @override
  Future<bool> sendPromotionalAlert(String userId, String vendorId, String title, String message) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final notification = NotificationEntity.createPromotionalAlert(
      userId: userId,
      vendorId: vendorId,
      title: title,
      message: message,
    );
    _notifications.add(NotificationModel.fromEntity(notification));
    return true;
  }

  @override
  Future<bool> sendWalletReminder(String userId, String title, String message) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final notification = NotificationEntity.createWalletReminder(
      userId: userId,
      title: title,
      message: message,
    );
    _notifications.add(NotificationModel.fromEntity(notification));
    return true;
  }

  @override
  Future<bool> sendAdminMessage(String userId, String title, String message) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final notification = NotificationEntity.createAdminMessage(
      userId: userId,
      title: title,
      message: message,
    );
    _notifications.add(NotificationModel.fromEntity(notification));
    return true;
  }

  @override
  Future<bool> broadcastPromotionalAlert(List<String> userIds, String vendorId, String title, String message) async {
    await Future.delayed(const Duration(milliseconds: 500));
    for (final userId in userIds) {
      final notification = NotificationEntity.createPromotionalAlert(
        userId: userId,
        vendorId: vendorId,
        title: title,
        message: message,
      );
      _notifications.add(NotificationModel.fromEntity(notification));
    }
    return true;
  }

  @override
  Future<bool> broadcastAdminMessage(List<String> userIds, String title, String message) async {
    await Future.delayed(const Duration(milliseconds: 500));
    for (final userId in userIds) {
      final notification = NotificationEntity.createAdminMessage(
        userId: userId,
        title: title,
        message: message,
      );
      _notifications.add(NotificationModel.fromEntity(notification));
    }
    return true;
  }

  @override
  Future<bool> broadcastWalletReminder(List<String> userIds, String title, String message) async {
    await Future.delayed(const Duration(milliseconds: 500));
    for (final userId in userIds) {
      final notification = NotificationEntity.createWalletReminder(
        userId: userId,
        title: title,
        message: message,
      );
      _notifications.add(NotificationModel.fromEntity(notification));
    }
    return true;
  }
}
