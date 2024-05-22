part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;
  final List<NotificationModel>? notifications;

  const NotificationsState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
    this.notifications,
  });

  NotificationsState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
    bool? createConversationSuccess,
    List<NotificationModel>? notifications,
    List<UserModel>? users,
  }) {
    return NotificationsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        success,
        notifications,
      ];
}
