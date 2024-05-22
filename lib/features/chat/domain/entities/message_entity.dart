import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final int? id;
  final int? conversationId;
  final String? userId;
  final String? content;
  final DateTime? createdAt;
  final bool? isMine;

  const MessageEntity(
    this.id,
    this.conversationId,
    this.userId,
    this.content,
    this.createdAt,
    this.isMine,
  );

  @override
  List<Object?> get props => [
        id,
        conversationId,
        userId,
        content,
        createdAt,
        isMine,
      ];
}
