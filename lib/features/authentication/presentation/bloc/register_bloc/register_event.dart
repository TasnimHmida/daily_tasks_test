part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends RegisterEvent {
  final String userName;
  final String email;
  final String password;

  RegisterUserEvent({
    required this.userName,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [userName,email, password];
}
