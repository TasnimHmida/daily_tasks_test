import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  @override
  const MessageModel({
    String? id,
    String? conversationId,
    String? userId,
    String? content,
    DateTime? createdAt,
    bool? isMine,
  }) : super(
          id,
          conversationId,
          userId,
          content,
          createdAt,
          isMine,
        );

  factory MessageModel.fromJson(
      {required Map<String, dynamic> json, required String myUserId}) {
    return MessageModel(
        id: json['id'],
        conversationId: json['conversation_id'],
        userId: json['user_id'],
        content: json['content'] ?? '',
        createdAt: DateTime.parse(json['created_at']),
        isMine: myUserId == json['user_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      "message_id": id,
      "conversation_id": conversationId,
      "user_id": userId,
      "content": content,
      "created_at": createdAt,
      "is_mine": isMine,
    };
  }
}
