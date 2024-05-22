import '../../../manage_user/data/models/user_model.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  @override
  const NotificationModel({
    int? id,
    UserModel? userModel,
    DateTime? createdAt,
    String? userId,
    String? content,
  }) : super(
          id,
          userModel,
          createdAt,
          userId,
    content,
        );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userModel: UserModel.fromJson(json['user']),
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      content: json['content'],
    );
  }
}
