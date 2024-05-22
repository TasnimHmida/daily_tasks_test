part of 'conversations_bloc.dart';

class ConversationsState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;
  final bool createConversationSuccess;
  final List<ConversationModel>? conversations;
  final List<UserModel>? users;

  const ConversationsState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
    this.createConversationSuccess = false,
    this.conversations,
    this.users,
  });

  ConversationsState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
    bool? createConversationSuccess,
    List<ConversationModel>? conversations,
    List<UserModel>? users,
  }) {
    return ConversationsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
      createConversationSuccess:
          createConversationSuccess ?? this.createConversationSuccess,
      conversations: conversations ?? this.conversations,
      users: users ?? this.users,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        success,
        createConversationSuccess,
        conversations,
        users,
      ];
}
