import '../../domain/entities/user_entity.dart';
class UserModel extends UserEntity {
  @override
  const UserModel({
    String? userName,
    String? email,
    String? password,
    String? profilePicture,
  }) : super(
          userName,
          email,
          password,
    profilePicture,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['username'],
      email: json['email'],
      password: json['password'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_name": userName,
      "email": email,
      "password": password,
      "profile_picture": profilePicture,
    };
  }
}
