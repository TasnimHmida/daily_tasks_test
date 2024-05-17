import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  @override
  const UserModel({
    String? userId,
    String? userName,
    String? email,
    String? password,
    String? profilePicture,
  }) : super(
          userId,
          userName,
          email,
          password,
          profilePicture,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      userName: json['username'],
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "user_name": userName,
      "email": email,
      "password": password,
      "profile_picture": profilePicture,
    };
  }
}
