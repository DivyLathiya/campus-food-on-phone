part of 'admin_message_bloc.dart';

abstract class AdminMessageEvent extends Equatable {
  const AdminMessageEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends AdminMessageEvent {
  const LoadUsers();
}

class SendAdminMessage extends AdminMessageEvent {
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

class SendBroadcastAdminMessage extends AdminMessageEvent {
  final List<String> userIds;
  final String title;
  final String message;

  const SendBroadcastAdminMessage({
    required this.userIds,
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [userIds, title, message];
}

class ClearAdminMessageForm extends AdminMessageEvent {
  const ClearAdminMessageForm();
}
