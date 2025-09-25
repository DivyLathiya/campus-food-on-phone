import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

enum NotificationType {
  orderStatus,
  promotionalAlert,
  walletReminder,
  adminMessage,
}

enum NotificationPriority {
  low,
  medium,
  high,
  urgent,
}

enum NotificationStatus {
  unread,
  read,
  archived,
}

class NotificationEntity extends Equatable {
  final String notificationId;
  final String userId;
  final NotificationType type;
  final NotificationPriority priority;
  final NotificationStatus status;
  final String title;
  final String message;
  final Map<String, dynamic>? data;
  final DateTime createdAt;
  final DateTime? readAt;
  final DateTime? archivedAt;
  final bool isActionable;
  final String? actionType;
  final String? actionData;

  const NotificationEntity({
    required this.notificationId,
    required this.userId,
    required this.type,
    required this.priority,
    required this.status,
    required this.title,
    required this.message,
    this.data,
    required this.createdAt,
    this.readAt,
    this.archivedAt,
    this.isActionable = false,
    this.actionType,
    this.actionData,
  });

  @override
  List<Object?> get props {
    return [
      notificationId,
      userId,
      type,
      priority,
      status,
      title,
      message,
      data,
      createdAt,
      readAt,
      archivedAt,
      isActionable,
      actionType,
      actionData,
    ];
  }

  NotificationEntity copyWith({
    String? notificationId,
    String? userId,
    NotificationType? type,
    NotificationPriority? priority,
    NotificationStatus? status,
    String? title,
    String? message,
    Map<String, dynamic>? data,
    DateTime? createdAt,
    DateTime? readAt,
    DateTime? archivedAt,
    bool? isActionable,
    String? actionType,
    String? actionData,
  }) {
    return NotificationEntity(
      notificationId: notificationId ?? this.notificationId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      title: title ?? this.title,
      message: message ?? this.message,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
      archivedAt: archivedAt ?? this.archivedAt,
      isActionable: isActionable ?? this.isActionable,
      actionType: actionType ?? this.actionType,
      actionData: actionData ?? this.actionData,
    );
  }

  bool get isUnread => status == NotificationStatus.unread;
  bool get isRead => status == NotificationStatus.read;
  bool get isArchived => status == NotificationStatus.archived;

  bool get isOrderNotification => type == NotificationType.orderStatus;
  bool get isPromotionalNotification => type == NotificationType.promotionalAlert;
  bool get isWalletNotification => type == NotificationType.walletReminder;
  bool get isAdminNotification => type == NotificationType.adminMessage;

  String get typeDisplay {
    switch (type) {
      case NotificationType.orderStatus:
        return 'Order Update';
      case NotificationType.promotionalAlert:
        return 'Promotion';
      case NotificationType.walletReminder:
        return 'Wallet';
      case NotificationType.adminMessage:
        return 'Admin';
    }
  }

  String get priorityDisplay {
    switch (priority) {
      case NotificationPriority.low:
        return 'Low';
      case NotificationPriority.medium:
        return 'Medium';
      case NotificationPriority.high:
        return 'High';
      case NotificationPriority.urgent:
        return 'Urgent';
    }
  }

  Color getPriorityColor() {
    switch (priority) {
      case NotificationPriority.low:
        return Colors.grey;
      case NotificationPriority.medium:
        return Colors.blue;
      case NotificationPriority.high:
        return Colors.orange;
      case NotificationPriority.urgent:
        return Colors.red;
    }
  }

  IconData getTypeIcon() {
    switch (type) {
      case NotificationType.orderStatus:
        return Icons.receipt_long;
      case NotificationType.promotionalAlert:
        return Icons.local_offer;
      case NotificationType.walletReminder:
        return Icons.account_balance_wallet;
      case NotificationType.adminMessage:
        return Icons.admin_panel_settings;
    }
  }

  static NotificationEntity createOrderStatusNotification({
    required String userId,
    required String orderId,
    required String status,
    required String title,
    required String message,
    NotificationPriority priority = NotificationPriority.medium,
    bool isActionable = true,
  }) {
    return NotificationEntity(
      notificationId: 'order_${orderId}_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      type: NotificationType.orderStatus,
      priority: priority,
      status: NotificationStatus.unread,
      title: title,
      message: message,
      data: {
        'orderId': orderId,
        'status': status,
      },
      createdAt: DateTime.now(),
      isActionable: isActionable,
      actionType: 'view_order',
      actionData: orderId,
    );
  }

  static NotificationEntity createPromotionalAlert({
    required String userId,
    required String vendorId,
    required String title,
    required String message,
    NotificationPriority priority = NotificationPriority.medium,
    bool isActionable = true,
  }) {
    return NotificationEntity(
      notificationId: 'promo_${vendorId}_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      type: NotificationType.promotionalAlert,
      priority: priority,
      status: NotificationStatus.unread,
      title: title,
      message: message,
      data: {
        'vendorId': vendorId,
      },
      createdAt: DateTime.now(),
      isActionable: isActionable,
      actionType: 'view_vendor',
      actionData: vendorId,
    );
  }

  static NotificationEntity createWalletReminder({
    required String userId,
    required String title,
    required String message,
    NotificationPriority priority = NotificationPriority.medium,
    bool isActionable = true,
  }) {
    return NotificationEntity(
      notificationId: 'wallet_${userId}_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      type: NotificationType.walletReminder,
      priority: priority,
      status: NotificationStatus.unread,
      title: title,
      message: message,
      createdAt: DateTime.now(),
      isActionable: isActionable,
      actionType: 'add_funds',
      actionData: '',
    );
  }

  static NotificationEntity createAdminMessage({
    required String userId,
    required String title,
    required String message,
    NotificationPriority priority = NotificationPriority.high,
    bool isActionable = false,
  }) {
    return NotificationEntity(
      notificationId: 'admin_${userId}_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      type: NotificationType.adminMessage,
      priority: priority,
      status: NotificationStatus.unread,
      title: title,
      message: message,
      createdAt: DateTime.now(),
      isActionable: isActionable,
    );
  }
}
