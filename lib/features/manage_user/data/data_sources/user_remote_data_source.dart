import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../manage_user/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUserInfo();

  Future<List<UserModel>> getAllUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final PrefUtils prefUtils;
  final SupabaseClient supabase;

  UserRemoteDataSourceImpl({required this.supabase, required this.prefUtils});

  @override
  Future<UserModel> getUserInfo() async {
    try {
      UserResponse? user = await supabase.auth.getUser();

      return UserModel(
        userId: user.user?.id,
        userName: user.user?.userMetadata?['username'],
        email: user.user?.userMetadata?['email'],
        profilePicture: user.user?.userMetadata?['profile_picture'],
      );
    } catch (e) {
      throw ServerException(message: 'No user logged in');
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
    final users = await supabase.from('members').select();
    final List<UserModel> userModels = users
        .map<UserModel>((jsonModel) => UserModel.fromJson(jsonModel))
        .toList();
    return userModels;
    } catch (e) {
      throw ServerException(message: 'No users found');
    }
  }
}
