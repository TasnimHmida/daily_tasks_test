import 'package:dartz/dartz.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../models/conversation_model.dart';

abstract class ChatRemoteDataSource {
  Future<Unit> createConversation(UserModel userTwo);

  Future<List<ConversationModel>> getConversations();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final PrefUtils prefUtils;
  final SupabaseClient supabase;

  ChatRemoteDataSourceImpl({required this.supabase, required this.prefUtils});

  @override
  Future<List<ConversationModel>> getConversations() async {
    try {
      var user = prefUtils.getUserInfo();
      final response = await supabase
          .from('conversations')
          .select()
          .eq('user_id', user?.userId ?? '');

      final List<ConversationModel> projects = response
          .map<ConversationModel>((jsonModel) => ConversationModel.fromJson(
              json: jsonModel, myUserId: user?.userId ?? ''))
          .toList();

      return projects;
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }

  @override
  Future<Unit> createConversation(
    UserModel userTwo,
  ) async {
    try {
      final UserModel? userOne = prefUtils.getUserInfo();
      await supabase.from('conversations').insert([
        {
          "user_id": userOne?.userId,
          "user_1": {
            "username": userOne?.userName,
            "user_id": userOne?.userId,
            "profile_picture": userOne?.profilePicture,
          },
          "user_2": {
            "username": userTwo.userName,
            "user_id": userTwo.userId,
            "profile_picture": userTwo.profilePicture,
          },
        }
      ]);

      return Future.value(unit);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
