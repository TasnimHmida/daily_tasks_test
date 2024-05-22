import 'package:equatable/equatable.dart';

import '../../../manage_user/data/models/user_model.dart';

class ConversationEntity extends Equatable {
  final int? id;
  final UserModel? contact;
  final DateTime? lastMessageDate;
  final String? lastMessage;

  const ConversationEntity(
    this.id,
    this.contact,
    this.lastMessageDate,
    this.lastMessage,
  );

  @override
  List<Object?> get props => [
        id,
        contact,
        lastMessageDate,
    lastMessage,
      ];
}
