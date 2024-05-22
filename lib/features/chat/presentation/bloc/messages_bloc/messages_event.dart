part of 'messages_bloc.dart';

abstract class MessagesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendMessageEvent extends MessagesEvent {
  final String messageContent;
  final String conversationId;
  final String userId;

  SendMessageEvent({
    required this.messageContent,
    required this.conversationId,
    required this.userId,
  });

  @override
  List<Object> get props => [
        messageContent,
        conversationId,
    userId,
      ];
}

class GetMessagesEvent extends MessagesEvent {
  final String conversationId;

  GetMessagesEvent({
    required this.conversationId,
  });

  @override
  List<Object> get props => [
        conversationId,
      ];
}
class RefreshMessagesEvent extends MessagesEvent {
  final String conversationId;

  RefreshMessagesEvent({
    required this.conversationId,
  });

  @override
  List<Object> get props => [
        conversationId,
      ];
}
