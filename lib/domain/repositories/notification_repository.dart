import 'package:campus_food_app/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<List<NotificationEntity>> getUserNotifications(String userId);
  Future<List<NotificationEntity>> getNotificationsByType(String userId, NotificationType type);
  Future<List<NotificationEntity>> getUnreadNotifications(String userId);
  Future<NotificationEntity?> getNotificationById(String notificationId);
  Future<NotificationEntity> createNotification(NotificationEntity notification);
  Future<NotificationEntity> updateNotification(NotificationEntity notification);
  Future<bool> markAsRead(String notificationId);
  Future<bool> markAsArchived(String notificationId);
  Future<bool> markAllAsRead(String userId);
  Future<bool> deleteNotification(String notificationId);
  Future<int> getUnreadCount(String userId);
  Future<List<NotificationEntity>> getNotificationsByPriority(String userId, NotificationPriority priority);
  Future<List<NotificationEntity>> getNotificationsByDateRange(String userId, DateTime startDate, DateTime endDate);
  Future<bool> sendOrderStatusNotification(String userId, String orderId, String status, String title, String message);
  Future<bool> sendPromotionalAlert(String userId, String vendorId, String title, String message);
  Future<bool> sendWalletReminder(String userId, String title, String message);
  Future<bool> sendAdminMessage(String userId, String title, String message);
  Future<bool> broadcastPromotionalAlert(List<String> userIds, String vendorId, String title, String message);
  Future<bool> broadcastAdminMessage(List<String> userIds, String title, String message);
  Future<bool> broadcastWalletReminder(List<String> userIds, String title, String message);
}
