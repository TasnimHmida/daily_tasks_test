import 'package:shared_preferences/shared_preferences.dart';
import '../../features/authentication/data/models/user_model.dart';

abstract class PrefUtils {
  UserModel? getUserInfo();

  void setUserInfo(
      {String? userId, String? name, String? email, String? password,
      String? profilePicture});

  void removeUserInfo();
}

class PrefUtilsImpl implements PrefUtils {
  final SharedPreferences sharedPreferences;

  PrefUtilsImpl({
    required this.sharedPreferences,
  });

  @override
  UserModel? getUserInfo() {
    if (sharedPreferences.containsKey('user_name') &&
        sharedPreferences.containsKey('user_email') &&
        sharedPreferences.containsKey('user_id') &&
        sharedPreferences.containsKey('user_password')) {
      String? name = sharedPreferences.getString("user_name");
      String? email = sharedPreferences.getString("user_email");
      String? userId = sharedPreferences.getString("user_id");
      String? password = sharedPreferences.getString("user_password");
      if (sharedPreferences.containsKey('user_picture')) {
        String? picture = sharedPreferences.getString("user_picture");
        return UserModel(
            userId: userId,
            userName: name,
            email: email,
            password: password,
            profilePicture: picture);
      } else {
        return UserModel(
            userId: userId, userName: name, email: email, password: password);
      }
    } else {
      return null;
    }
  }

  @override
  void setUserInfo(
      { String? userId,
       String? name,
       String? email,
       String? password,
      String? profilePicture}) {
    if (userId != null) {
      sharedPreferences.setString("user_id", userId);
    }if (name != null) {
      sharedPreferences.setString("user_name", name);
    }if (email != null) {
      sharedPreferences.setString("user_email", email);
    }if (password != null) {
      sharedPreferences.setString("user_password", password);
    }if (profilePicture != null) {
      sharedPreferences.setString("user_picture", profilePicture);
    }
  }

  @override
  void removeUserInfo() {
    if (sharedPreferences.containsKey('user_name')) {
      sharedPreferences.remove('user_name');
    }
    if (sharedPreferences.containsKey('user_email')) {
      sharedPreferences.remove('user_email');
    }
    if (sharedPreferences.containsKey('user_id')) {
      sharedPreferences.remove('user_id');
    }
    if (sharedPreferences.containsKey('user_password')) {
      sharedPreferences.remove('user_password');
    }
    if (sharedPreferences.containsKey('user_picture')) {
      sharedPreferences.remove('user_picture');
    }
  }
}
