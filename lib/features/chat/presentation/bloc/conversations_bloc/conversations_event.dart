part of 'conversations_bloc.dart';

abstract class ConversationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateConversationEvent extends ConversationEvent {
  final UserModel userTwo;

  CreateConversationEvent({
    required this.userTwo,
  });

  @override
  List<Object> get props => [
        userTwo,
      ];
}
class GetConversationsEvent extends ConversationEvent {}
class CreateConversationUsersEvent extends ConversationEvent {
  final List<ConversationModel> conversations;
  CreateConversationUsersEvent({
    required this.conversations,
  });

  @override
  List<Object> get props => [
    conversations,
  ];

}