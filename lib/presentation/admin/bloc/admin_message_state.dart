part of 'admin_message_bloc.dart';

abstract class AdminMessageState extends Equatable {
  const AdminMessageState();

  @override
  List<Object> get props => [];
}

class AdminMessageInitial extends AdminMessageState {
  const AdminMessageInitial();
}

class AdminMessageLoading extends AdminMessageState {
  const AdminMessageLoading();
}

class AdminMessageSending extends AdminMessageState {
  const AdminMessageSending();
}

class AdminMessageUsersLoaded extends AdminMessageState {
  final List<UserEntity> users;

  const AdminMessageUsersLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class AdminMessageSent extends AdminMessageState {
  const AdminMessageSent();
}

class AdminMessageBroadcastSent extends AdminMessageState {
  final int recipientCount;

  const AdminMessageBroadcastSent({required this.recipientCount});

  @override
  List<Object> get props => [recipientCount];
}

class AdminMessageError extends AdminMessageState {
  final String message;

  const AdminMessageError({required this.message});

  @override
  List<Object> get props => [message];
}
