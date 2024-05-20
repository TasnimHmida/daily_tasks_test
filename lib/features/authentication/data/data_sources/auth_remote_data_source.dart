import 'package:dartz/dartz.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../manage_user/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);

  Future<Unit> signUp(
      {required String email,
      required String password,
      required String userName});

  Future<Unit> signOut();

  Future<UserModel> getUserInfo();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final PrefUtils prefUtils;
  final SupabaseClient supabase;

  AuthRemoteDataSourceImpl({required this.supabase, required this.prefUtils});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      UserResponse? user = await supabase.auth.getUser();
      prefUtils.setUserInfo(
        userId: user.user?.id,
        name: user.user?.userMetadata?['username'],
        email: user.user?.userMetadata?['email'],
        profilePicture: user.user?.userMetadata?['profile_picture'],
        password: password,
      );
      return UserModel(
        userId: user.user?.id,
        userName: user.user?.userMetadata?['username'],
        email: user.user?.userMetadata?['email'],
        profilePicture: user.user?.userMetadata?['profile_picture'],
      );
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Unit> signUp(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': userName,
        },
      );
      UserResponse? user = await supabase.auth.getUser();

      await supabase.from('members').insert({
        'user_id': user.user?.id,
        'username': userName,
      });

      await supabase.auth.signOut();
      return Future.value(unit);
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Unit> signOut() async {
    try {
      await supabase.auth.signOut();
      prefUtils.removeUserInfo();
      return Future.value(unit);
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<UserModel> getUserInfo() async {
    try {
      UserResponse? user = await supabase.auth.getUser();

      if (user != null) {
        return UserModel(
          userId: user.user?.id,
          userName: user.user?.userMetadata?['username'],
          email: user.user?.userMetadata?['email'],
          profilePicture: user.user?.userMetadata?['profile_picture'],
        );
      } else {
        throw ServerException(message: 'No user logged in');
      }
    } catch (e) {
      throw ServerException(message: 'No user logged in');
    }
  }
}
