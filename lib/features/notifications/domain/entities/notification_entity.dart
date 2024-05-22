import 'package:equatable/equatable.dart';

import '../../../manage_user/data/models/user_model.dart';

class NotificationEntity extends Equatable {
  final int? id;
  final UserModel? userModel;
  final DateTime? createdAt;
  final String? userId;
  final String? content;

  const NotificationEntity(
    this.id,
    this.userModel,
    this.createdAt,
    this.userId,
    this.content,
  );

  @override
  List<Object?> get props => [
        id,
        userModel,
        createdAt,
        userId,
        content,
      ];
}
