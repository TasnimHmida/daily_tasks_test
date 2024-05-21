part of 'messages_bloc.dart';

class MessagesState extends Equatable {
  final bool isLoading;
  final String error;
  final String conversationId;
  final bool success;
  final List<MessageModel>? messages;

  const MessagesState({
    this.isLoading = false,
    this.error = "",
    this.conversationId = "",
    this.success = false,
    this.messages,
  });

  MessagesState copyWith({
    bool? isLoading,
    String? error,
    String? conversationId,
    bool? success,
    List<MessageModel>? messages,
  }) {
    return MessagesState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      conversationId: conversationId ?? this.conversationId,
      success: success ?? this.success,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        conversationId,
        error,
        success,
        messages,
      ];
}
