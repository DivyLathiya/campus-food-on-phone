part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationsLoaded extends NotificationState {
  final List<NotificationEntity> notifications;
  final int unreadCount;
  final NotificationType? currentFilter;
  final NotificationPriority? currentPriorityFilter;

  const NotificationsLoaded({
    required this.notifications,
    required this.unreadCount,
    this.currentFilter,
    this.currentPriorityFilter,
  });

  @override
  List<Object> get props => [
        notifications,
        unreadCount,
        currentFilter ?? '',
        currentPriorityFilter ?? '',
      ];

  NotificationsLoaded copyWith({
    List<NotificationEntity>? notifications,
    int? unreadCount,
    NotificationType? currentFilter,
    NotificationPriority? currentPriorityFilter,
  }) {
    return NotificationsLoaded(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      currentFilter: currentFilter ?? this.currentFilter,
      currentPriorityFilter: currentPriorityFilter ?? this.currentPriorityFilter,
    );
  }
}

class UnreadNotificationsLoaded extends NotificationState {
  final List<NotificationEntity> unreadNotifications;

  const UnreadNotificationsLoaded({required this.unreadNotifications});

  @override
  List<Object> get props => [unreadNotifications];
}

class NotificationOperationSuccess extends NotificationState {
  final String message;

  const NotificationOperationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError({required this.message});

  @override
  List<Object> get props => [message];
}

class UnreadCountLoaded extends NotificationState {
  final int count;

  const UnreadCountLoaded({required this.count});

  @override
  List<Object> get props => [count];
}
