import 'package:shared_preferences/shared_preferences.dart';
import '../../features/authentication/data/models/user_model.dart';

abstract class PrefUtils {
  UserModel? getUserInfo();
  void setUserInfo({required String userId, required String name, required String email});
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
        sharedPreferences.containsKey('user_id')
    ) {
      String? name = sharedPreferences.getString("user_name");
      String? email = sharedPreferences.getString("user_email");
      String? userId = sharedPreferences.getString("user_id");
      return UserModel(userId: userId, userName: name, email: email);
    } else {
      return null;
    }
  }

  @override
  void setUserInfo({required String userId,required String name, required String email}) {
    sharedPreferences.setString("user_name", name);
    sharedPreferences.setString("user_email", email);
    sharedPreferences.setString("user_id", userId);
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
  }
}
