part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;
  final UserModel? user;

  const LoginState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
    this.user,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
    UserModel? user,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        success,
        user,
      ];
}
