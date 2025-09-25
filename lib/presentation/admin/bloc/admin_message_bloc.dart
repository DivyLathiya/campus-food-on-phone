import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/user_entity.dart';
import 'package:campus_food_app/domain/repositories/notification_repository.dart';
import 'package:campus_food_app/domain/repositories/user_repository.dart';

part 'admin_message_event.dart';
part 'admin_message_state.dart';

class AdminMessageBloc extends Bloc<AdminMessageEvent, AdminMessageState> {
  final NotificationRepository notificationRepository;
  final UserRepository userRepository;

  AdminMessageBloc({
    required this.notificationRepository,
    required this.userRepository,
  }) : super(AdminMessageInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<SendAdminMessage>(_onSendAdminMessage);
    on<SendBroadcastAdminMessage>(_onSendBroadcastAdminMessage);
    on<ClearAdminMessageForm>(_onClearAdminMessageForm);
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<AdminMessageState> emit) async {
    emit(AdminMessageLoading());
    try {
      final users = await userRepository.getAllUsers();
      emit(AdminMessageUsersLoaded(users: users));
    } catch (e) {
      emit(AdminMessageError(message: 'Failed to load users: ${e.toString()}'));
    }
  }

  Future<void> _onSendAdminMessage(SendAdminMessage event, Emitter<AdminMessageState> emit) async {
    emit(AdminMessageSending());
    try {
      final success = await notificationRepository.sendAdminMessage(
        event.userId,
        event.title,
        event.message,
      );

      if (success) {
        emit(AdminMessageSent());
      } else {
        emit(AdminMessageError(message: 'Failed to send admin message'));
      }
    } catch (e) {
      emit(AdminMessageError(message: 'Failed to send admin message: ${e.toString()}'));
    }
  }

  Future<void> _onSendBroadcastAdminMessage(SendBroadcastAdminMessage event, Emitter<AdminMessageState> emit) async {
    emit(AdminMessageSending());
    try {
      final success = await notificationRepository.broadcastAdminMessage(
        event.userIds,
        event.title,
        event.message,
      );

      if (success) {
        emit(AdminMessageBroadcastSent(recipientCount: event.userIds.length));
      } else {
        emit(AdminMessageError(message: 'Failed to broadcast admin message'));
      }
    } catch (e) {
      emit(AdminMessageError(message: 'Failed to broadcast admin message: ${e.toString()}'));
    }
  }

  Future<void> _onClearAdminMessageForm(ClearAdminMessageForm event, Emitter<AdminMessageState> emit) async {
    emit(AdminMessageInitial());
  }
}
