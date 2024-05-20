part of 'conversations_bloc.dart';

class ConversationsState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;
  final List<ConversationModel>? conversations;

  const ConversationsState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
    this.conversations,
  });

  ConversationsState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
    List<ConversationModel>? conversations,
  }) {
    return ConversationsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
      conversations: conversations ?? this.conversations,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        success,
        conversations,
      ];
}
