import 'package:dartz/dartz.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../../../core/error/exception.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> login(String email, String password);

  Future<Unit> signUp(String email, String password, String userName);

  Future<Unit> signOut();
  Future<UserModel> getUserInfo();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabase;

  AuthRemoteDataSourceImpl({required this.supabase});

  @override
  Future<Unit> login(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return Future.value(unit);
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Unit> signUp(String email, String password, String userName) async {
    print(email);
    print(userName);
    print(password);
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': userName,
        },
      );

      return Future.value(unit);
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Unit> signOut() async {
    try {
      await supabase.auth.signOut();

      return Future.value(unit);
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    }
  }
  @override
  Future<UserModel> getUserInfo() async {
    try {
      UserResponse? user = await supabase.auth.getUser();
      return UserModel.fromJson(user.user?.userMetadata?['username']);
    } catch (e) {
      throw ServerException(message: 'No user logged in');
    }
  }
}
