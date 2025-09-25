part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class LoadNotifications extends NotificationEvent {
  final String userId;

  const LoadNotifications({required this.userId});

  @override
  List<Object> get props => [userId];
}

class LoadNotificationsByType extends NotificationEvent {
  final String userId;
  final NotificationType type;

  const LoadNotificationsByType({
    required this.userId,
    required this.type,
  });

  @override
  List<Object> get props => [userId, type];
}

class LoadUnreadNotifications extends NotificationEvent {
  final String userId;

  const LoadUnreadNotifications({required this.userId});

  @override
  List<Object> get props => [userId];
}

class LoadNotificationsByPriority extends NotificationEvent {
  final String userId;
  final NotificationPriority priority;

  const LoadNotificationsByPriority({
    required this.userId,
    required this.priority,
  });

  @override
  List<Object> get props => [userId, priority];
}

class MarkNotificationAsRead extends NotificationEvent {
  final String notificationId;

  const MarkNotificationAsRead({required this.notificationId});

  @override
  List<Object> get props => [notificationId];
}

class MarkNotificationAsArchived extends NotificationEvent {
  final String notificationId;

  const MarkNotificationAsArchived({required this.notificationId});

  @override
  List<Object> get props => [notificationId];
}

class MarkAllNotificationsAsRead extends NotificationEvent {
  final String userId;

  const MarkAllNotificationsAsRead({required this.userId});

  @override
  List<Object> get props => [userId];
}

class DeleteNotification extends NotificationEvent {
  final String notificationId;

  const DeleteNotification({required this.notificationId});

  @override
  List<Object> get props => [notificationId];
}

class RefreshNotifications extends NotificationEvent {
  final String userId;

  const RefreshNotifications({required this.userId});

  @override
  List<Object> get props => [userId];
}

class GetUnreadCount extends NotificationEvent {
  final String userId;

  const GetUnreadCount({required this.userId});

  @override
  List<Object> get props => [userId];
}

class SendOrderStatusNotification extends NotificationEvent {
  final String userId;
  final String orderId;
  final String status;
  final String title;
  final String message;

  const SendOrderStatusNotification({
    required this.userId,
    required this.orderId,
    required this.status,
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [userId, orderId, status, title, message];
}

class SendPromotionalAlert extends NotificationEvent {
  final String userId;
  final String vendorId;
  final String title;
  final String message;

  const SendPromotionalAlert({
    required this.userId,
    required this.vendorId,
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [userId, vendorId, title, message];
}

class SendWalletReminder extends NotificationEvent {
  final String userId;
  final String title;
  final String message;

  const SendWalletReminder({
    required this.userId,
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [userId, title, message];
}

class SendAdminMessage extends NotificationEvent {
  final String userId;
  final String title;
  final String message;

  const SendAdminMessage({
    required this.userId,
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [userId, title, message];
}
