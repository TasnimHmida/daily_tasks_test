import '../../../manage_user/data/models/user_model.dart';
import '../../domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  @override
  const ConversationModel({
    int? id,
    String? userId,
    UserModel? userOne,
    UserModel? userTwo,
    DateTime? createdAt,
  }) : super(
          id,
          userId,
          userOne,
          userTwo,
          createdAt,
        );

  factory ConversationModel.fromJson(
      {required Map<String, dynamic> json, required String myUserId}) {
    return ConversationModel(
      id: json['id'],
      userId: json['user_id'],
      userOne: UserModel.fromJson(json['user_1']),
      userTwo: UserModel.fromJson(json['user_2']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_1": {
        "username": userOne?.userName,
        "user_id": userOne?.userId,
        "profile_picture": userOne?.profilePicture,
      },
      "user_2": {
        "username": userTwo?.userName,
        "user_id": userTwo?.userId,
        "profile_picture": userTwo?.profilePicture,
      },
      "created_at": createdAt,
      "user_id": userId,
    };
  }
}
