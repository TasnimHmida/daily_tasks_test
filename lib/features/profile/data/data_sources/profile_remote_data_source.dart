import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../manage_user/data/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Unit> updateUser(UserModel user, File? image);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final PrefUtils prefUtils;
  final SupabaseClient supabase;

  ProfileRemoteDataSourceImpl(
      {required this.supabase, required this.prefUtils});

  Future<String> uploadImage(File imageFile, String id) async {
    final userId = id;
    final uuid = Uuid();
    final uniqueFileName = '${uuid.v4()}';
    try {
      var res = await supabase.storage
          .from('profile_pictures')
          .upload('$userId/profile_pictures/$uniqueFileName', imageFile);
      return supabase.storage
          .from('profile_pictures')
          .getPublicUrl('$userId/profile_pictures/$uniqueFileName');
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }

  @override
  Future<Unit> updateUser(UserModel user, File? image) async {
    try {
      final userId = prefUtils.getUserInfo()?.userId ?? '';
      if (image != null) {
        final imageUrl = await uploadImage(image, userId);
        await supabase.auth.updateUser(
          UserAttributes(data: {
            'profile_picture': imageUrl,
          }),
        );
        await supabase.from('members').update({
          'profile_picture': imageUrl,
        }).eq('user_id', userId);
        prefUtils.setUserInfo(
          profilePicture: imageUrl,
        );
      }
      if (user.password!.isNotEmpty &&
          user.password != prefUtils.getUserInfo()!.password) {
        await supabase.auth.updateUser(
          UserAttributes(password: user.password),
        );
      }
      if (user.email!.isNotEmpty &&
          user.email != prefUtils.getUserInfo()!.email) {
        await supabase.auth.updateUser(
          UserAttributes(email: user.email),
        );
      }
      if (user.userName!.isNotEmpty &&
          user.userName != prefUtils.getUserInfo()!.userName) {
        await supabase.auth.updateUser(
          UserAttributes(data: {
            'username': user.userName,
          }),
        );
      }

      prefUtils.setUserInfo(
        userId: user.userId,
        name: user.userName,
        email: user.email,
        password: user.password,
      );

      return Future.value(unit);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
