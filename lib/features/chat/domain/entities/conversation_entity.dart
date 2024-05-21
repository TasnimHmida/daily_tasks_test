import 'package:equatable/equatable.dart';

import '../../../manage_user/data/models/user_model.dart';

class ConversationEntity extends Equatable {
  final int? id;
  final UserModel? contact;
  final DateTime? createdAt;

  const ConversationEntity(
    this.id,
    this.contact,
    this.createdAt,
  );

  @override
  List<Object?> get props => [
        id,
        contact,
        createdAt,
      ];
}
