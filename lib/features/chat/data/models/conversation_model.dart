import '../../../manage_user/data/models/user_model.dart';
import '../../domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  @override
  const ConversationModel({
    int? id,
    UserModel? contact,
    DateTime? lastMessageDate,
    String? lastMessage,
  }) : super(
          id,
          contact,
          lastMessageDate,
          lastMessage,
        );

  factory ConversationModel.fromJson(
      {required Map<String, dynamic> json, required String myUserId}) {
    UserModel userOne = UserModel.fromJson(json['users'][0]);
    UserModel userTwo = UserModel.fromJson(json['users'][1]);
    UserModel otherUser = userOne.userId == myUserId ? userTwo : userOne;
    return ConversationModel(
      id: json['id'],
      contact: otherUser,
      lastMessage: json['last_message'],
      lastMessageDate: DateTime.parse(json['last_message_date']),
    );
  }
}
