import 'package:equatable/equatable.dart';

import '../../../manage_user/data/models/user_model.dart';

class ConversationEntity extends Equatable {
  final int? id;
  final String? userId;
  final UserModel? userOne;
  final UserModel? userTwo;
  final DateTime? createdAt;

  const ConversationEntity(
    this.id,
    this.userId,
    this.userOne,
    this.userTwo,
    this.createdAt,
  );

  @override
  List<Object?> get props => [
        id,
        userId,
        userOne,
        userTwo,
        createdAt,
      ];
}
