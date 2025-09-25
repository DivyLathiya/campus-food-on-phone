import 'package:campus_food_app/domain/entities/notification_entity.dart';

class NotificationModel {
  final String notificationId;
  final String userId;
  final String type;
  final String priority;
  final String status;
  final String title;
  final String message;
  final Map<String, dynamic>? data;
  final DateTime createdAt;
  final DateTime? readAt;
  final DateTime? archivedAt;
  final bool isActionable;
  final String? actionType;
  final String? actionData;

  NotificationModel({
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

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notificationId'] as String,
      userId: json['userId'] as String,
      type: json['type'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt'] as String) : null,
      archivedAt: json['archivedAt'] != null ? DateTime.parse(json['archivedAt'] as String) : null,
      isActionable: json['isActionable'] as bool? ?? false,
      actionType: json['actionType'] as String?,
      actionData: json['actionData'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationId': notificationId,
      'userId': userId,
      'type': type,
      'priority': priority,
      'status': status,
      'title': title,
      'message': message,
      'data': data,
      'createdAt': createdAt.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
      'archivedAt': archivedAt?.toIso8601String(),
      'isActionable': isActionable,
      'actionType': actionType,
      'actionData': actionData,
    };
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      notificationId: notificationId,
      userId: userId,
      type: _parseNotificationType(type),
      priority: _parseNotificationPriority(priority),
      status: _parseNotificationStatus(status),
      title: title,
      message: message,
      data: data,
      createdAt: createdAt,
      readAt: readAt,
      archivedAt: archivedAt,
      isActionable: isActionable,
      actionType: actionType,
      actionData: actionData,
    );
  }

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      notificationId: entity.notificationId,
      userId: entity.userId,
      type: entity.type.name,
      priority: entity.priority.name,
      status: entity.status.name,
      title: entity.title,
      message: entity.message,
      data: entity.data,
      createdAt: entity.createdAt,
      readAt: entity.readAt,
      archivedAt: entity.archivedAt,
      isActionable: entity.isActionable,
      actionType: entity.actionType,
      actionData: entity.actionData,
    );
  }

  NotificationType _parseNotificationType(String type) {
    switch (type) {
      case 'orderStatus':
        return NotificationType.orderStatus;
      case 'promotionalAlert':
        return NotificationType.promotionalAlert;
      case 'walletReminder':
        return NotificationType.walletReminder;
      case 'adminMessage':
        return NotificationType.adminMessage;
      default:
        return NotificationType.adminMessage;
    }
  }

  NotificationPriority _parseNotificationPriority(String priority) {
    switch (priority) {
      case 'low':
        return NotificationPriority.low;
      case 'medium':
        return NotificationPriority.medium;
      case 'high':
        return NotificationPriority.high;
      case 'urgent':
        return NotificationPriority.urgent;
      default:
        return NotificationPriority.medium;
    }
  }

  NotificationStatus _parseNotificationStatus(String status) {
    switch (status) {
      case 'unread':
        return NotificationStatus.unread;
      case 'read':
        return NotificationStatus.read;
      case 'archived':
        return NotificationStatus.archived;
      default:
        return NotificationStatus.unread;
    }
  }

  NotificationModel copyWith({
    String? notificationId,
    String? userId,
    String? type,
    String? priority,
    String? status,
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
    return NotificationModel(
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
}
