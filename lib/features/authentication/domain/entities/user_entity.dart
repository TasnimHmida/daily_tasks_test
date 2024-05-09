import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userName;
  final String? email;
  final String? password;
  final String? profilePicture;

  const UserEntity(
    this.userName,
    this.email,
    this.password,
    this.profilePicture,
  );

  @override
  List<Object?> get props => [
        userName,
        email,
        password,
    profilePicture,
      ];
}
