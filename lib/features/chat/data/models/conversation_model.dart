import '../../../manage_user/data/models/user_model.dart';
import '../../domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  @override
  const ConversationModel({
    int? id,
    UserModel? contact,
    DateTime? createdAt,
  }) : super(
          id,
          contact,
          createdAt,
        );

  factory ConversationModel.fromJson(
      {required Map<String, dynamic> json, required String myUserId}) {
    UserModel userOne = UserModel.fromJson(json['users'][0]);
    UserModel userTwo = UserModel.fromJson(json['users'][1]);
    UserModel otherUser = userOne.userId == myUserId ? userTwo : userOne;
    return ConversationModel(
      id: json['id'],
      contact: otherUser,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
