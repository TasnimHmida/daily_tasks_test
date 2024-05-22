import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../../data/models/notification_model.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, Unit>> createNewNotification(String userId, String content);

  Future<Either<Failure, List<NotificationModel>>> getNotifications();
}
