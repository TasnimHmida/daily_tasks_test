import 'package:dartz/dartz.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../models/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<Unit> createNewNotification(String userId, String content);

  Future<List<NotificationModel>> getNotifications();
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final PrefUtils prefUtils;
  final SupabaseClient supabase;

  NotificationsRemoteDataSourceImpl(
      {required this.supabase, required this.prefUtils});

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      var user = prefUtils.getUserInfo();
      final response = await supabase
          .from('notifications')
          .select()
          .eq('user_id', user?.userId ?? '');

      final List<NotificationModel> notifications = response
          .map<NotificationModel>(
              (jsonModel) => NotificationModel.fromJson(jsonModel))
          .toList();

      return notifications;
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }

  @override
  Future<Unit> createNewNotification(String userId, String content) async {
    try {
      final UserModel? userModel = prefUtils.getUserInfo();
      await supabase.from('notifications').insert({
        "user_id": userId,
        "content": content,
        "user":
          {
            "user_id": userModel?.userId,
            "username": userModel?.userName,
            "profile_picture": userModel?.profilePicture,
          }
      });

      return Future.value(unit);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
