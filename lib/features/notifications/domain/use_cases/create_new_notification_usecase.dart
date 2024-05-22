import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../repositories/notification_repository.dart';

class CreateNewNotificationUseCase {
  final NotificationsRepository repository;

  CreateNewNotificationUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(
      String userId, String content) async {
    return await repository.createNewNotification(userId, content);
  }
}
