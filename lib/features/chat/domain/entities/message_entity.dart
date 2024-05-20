import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String? id;
  final String? conversationId;
  final String? userId;
  final String? content;
  final DateTime? createdAt;
  final bool? isMine;

  const MessageEntity(
    this.id,
    this.userId,
    this.conversationId,
    this.content,
    this.createdAt,
    this.isMine,
  );

  @override
  List<Object?> get props => [
        id,
        userId,
        conversationId,
        content,
        createdAt,
        isMine,
      ];
}
