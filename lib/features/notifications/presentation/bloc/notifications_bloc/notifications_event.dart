part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateNewNotificationEvent extends NotificationsEvent {
  final String userId;
  final String content;

  CreateNewNotificationEvent({
    required this.userId,
    required this.content,
  });

  @override
  List<Object> get props => [
        userId,
    content,
      ];
}
class GetNotificationsEvent extends NotificationsEvent {}