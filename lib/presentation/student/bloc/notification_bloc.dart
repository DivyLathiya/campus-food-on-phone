import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/notification_entity.dart';
import 'package:campus_food_app/domain/repositories/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;

  NotificationBloc({
    required this.notificationRepository,
  }) : super(const NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<LoadNotificationsByType>(_onLoadNotificationsByType);
    on<LoadUnreadNotifications>(_onLoadUnreadNotifications);
    on<LoadNotificationsByPriority>(_onLoadNotificationsByPriority);
    on<MarkNotificationAsRead>(_onMarkNotificationAsRead);
    on<MarkNotificationAsArchived>(_onMarkNotificationAsArchived);
    on<MarkAllNotificationsAsRead>(_onMarkAllNotificationsAsRead);
    on<DeleteNotification>(_onDeleteNotification);
    on<RefreshNotifications>(_onRefreshNotifications);
    on<GetUnreadCount>(_onGetUnreadCount);
    on<SendOrderStatusNotification>(_onSendOrderStatusNotification);
    on<SendPromotionalAlert>(_onSendPromotionalAlert);
    on<SendWalletReminder>(_onSendWalletReminder);
    on<SendAdminMessage>(_onSendAdminMessage);
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoading());
    try {
      final notifications = await notificationRepository.getUserNotifications(event.userId);
      final unreadCount = await notificationRepository.getUnreadCount(event.userId);
      emit(NotificationsLoaded(
        notifications: notifications,
        unreadCount: unreadCount,
      ));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> _onLoadNotificationsByType(
    LoadNotificationsByType event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoading());
    try {
      final notifications = await notificationRepository.getNotificationsByType(event.userId, event.type);
      final unreadCount = await notificationRepository.getUnreadCount(event.userId);
      emit(NotificationsLoaded(
        notifications: notifications,
        unreadCount: unreadCount,
        currentFilter: event.type,
      ));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> _onLoadUnreadNotifications(
    LoadUnreadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoading());
    try {
      final unreadNotifications = await notificationRepository.getUnreadNotifications(event.userId);
      emit(UnreadNotificationsLoaded(unreadNotifications: unreadNotifications));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> _onLoadNotificationsByPriority(
    LoadNotificationsByPriority event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoading());
    try {
      final notifications = await notificationRepository.getNotificationsByPriority(event.userId, event.priority);
      final unreadCount = await notificationRepository.getUnreadCount(event.userId);
      emit(NotificationsLoaded(
        notifications: notifications,
        unreadCount: unreadCount,
        currentPriorityFilter: event.priority,
      ));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> _onMarkNotificationAsRead(
    MarkNotificationAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await notificationRepository.markAsRead(event.notificationId);
      if (state is NotificationsLoaded) {
        final currentState = state as NotificationsLoaded;
        final updatedNotifications = currentState.notifications.map((notification) {
          return notification.notificationId == event.notificationId
              ? notification.copyWith(status: NotificationStatus.read, readAt: DateTime.now())
              : notification;
        }).toList();
        
        final newUnreadCount = currentState.unreadCount > 0 ? currentState.unreadCount - 1 : 0;
        
        emit(currentState.copyWith(
          notifications: updatedNotifications,
          unreadCount: newUnreadCount,
        ));
      }
      emit(const NotificationOperationSuccess(message: 'Notification marked as read'));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> _onMarkNotificationAsArchived(
    MarkNotificationAsArchived event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await notificationRepository.markAsArchived(event.notificationId);
      if (state is NotificationsLoaded) {
        final currentState = state as NotificationsLoaded;
        final updatedNotifications = currentState.notifications
            .where((notification) => notification.notificationId != event.notificationId)
            .toList();
        
        final wasUnread = currentState.notifications
            .firstWhere((n) => n.notificationId == event.notificationId)
            .isUnread;
        
        final newUnreadCount = wasUnread && currentState.unreadCount > 0 
            ? currentState.unreadCount - 1 
            : currentState.unreadCount;
        
        emit(currentState.copyWith(
          notifications: updatedNotifications,
          unreadCount: newUnreadCount,
        ));
      }
      emit(const NotificationOperationSuccess(message: 'Notification archived'));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> _onMarkAllNotificationsAsRead(
    MarkAllNotificationsAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await notificationRepository.markAllAsRead(event.userId);
      if (state is NotificationsLoaded) {
        final currentState = state as NotificationsLoaded;
        final updatedNotifications = currentState.notifications.map((notification) {
          return notification.isUnread
              ? notification.copyWith(status: NotificationStatus.read, readAt: DateTime.now())
              : notification;
        }).toList();
        
        emit(currentState.copyWith(
          notifications: updatedNotifications,
          unreadCount: 0,
        ));
      }
      emit(const NotificationOperationSuccess(message: 'All notifications marked as read'));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> _onDeleteNotification(
    DeleteNotification event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await notificationRepository.deleteNotification(event.notificationId);
      if (state is NotificationsLoaded) {
        final currentState = state as NotificationsLoaded;
        final updatedNotifications = currentState.notifications
            .where((notification) => notification.notificationId != event.notificationId)
            .toList();
        
        final wasUnread = currentState.notifications
            .firstWhere((n) => n.notificationId == event.notificationId)
            .isUnread;
        
        final newUnreadCount = wasUnread && currentState.unreadCount > 0 
            ? currentState.unreadCount - 1 
            : currentState.unreadCount;
        
        emit(currentState.copyWith(
          notifications: updatedNotifications,
          unreadCount: newUnreadCount,
        ));
      }
      emit(const NotificationOperationSuccess(message: 'Notification deleted'));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> _onRefreshNotifications(
    RefreshNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoading());
    try {
      final notifications = await notificationRepository.getUserNotifications(event.userId);
      final unreadCount = await notificationRepository.getUnreadCount(event.userId);
      emit(NotificationsLoaded(
        notifications: notifications,
        unreadCount: unreadCount,
      ));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> _onGetUnreadCount(
    GetUnreadCount event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      final count = await notificationRepository.getUnreadCount(event.userId);
      emit(UnreadCountLoaded(count: count));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> _onSendOrderStatusNotification(
    SendOrderStatusNotification event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await notificationRepository.sendOrderStatusNotification(
        event.userId,
        event.orderId,
        event.status,
        event.title,
        event.message,
      );
      emit(const NotificationOperationSuccess(message: 'Order status notification sent'));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> _onSendPromotionalAlert(
    SendPromotionalAlert event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await notificationRepository.sendPromotionalAlert(
        event.userId,
        event.vendorId,
        event.title,
        event.message,
      );
      emit(const NotificationOperationSuccess(message: 'Promotional alert sent'));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> _onSendWalletReminder(
    SendWalletReminder event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await notificationRepository.sendWalletReminder(
        event.userId,
        event.title,
        event.message,
      );
      emit(const NotificationOperationSuccess(message: 'Wallet reminder sent'));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> _onSendAdminMessage(
    SendAdminMessage event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await notificationRepository.sendAdminMessage(
        event.userId,
        event.title,
        event.message,
      );
      emit(const NotificationOperationSuccess(message: 'Admin message sent'));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }
}
