import 'package:shared_preferences/shared_preferences.dart';
import '../../features/authentication/data/models/user_model.dart';

abstract class PrefUtils {
  UserModel? getUserInfo();
  void setUserInfo({required String name, required String email});
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
        sharedPreferences.containsKey('user_email')) {
      String? name = sharedPreferences.getString("user_name");
      String? email = sharedPreferences.getString("user_email");
      return UserModel(userName: name, email: email);
    } else {
      return null;
    }
  }

  @override
  void setUserInfo({required String name, required String email}) {
    sharedPreferences.setString("user_name", name);
    sharedPreferences.setString("user_email", email);
  }

  @override
  void removeUserInfo() {
    if (sharedPreferences.containsKey('user_name')) {
      sharedPreferences.remove('user_name');
    }
    if (sharedPreferences.containsKey('user_email')) {
      sharedPreferences.remove('user_email');
    }
  }
}
