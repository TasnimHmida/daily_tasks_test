import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/notification_model.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationsRepository repository;
  GetNotificationsUseCase({required this.repository});

  Future<Either<Failure, List<NotificationModel>>> call() async {
    return await repository.getNotifications();
  }
}
