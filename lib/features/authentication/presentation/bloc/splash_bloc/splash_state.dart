part of 'splash_bloc.dart';

class SplashState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;
  final UserModel? user;

  const SplashState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
    this.user,
  });

  SplashState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
    UserModel? user,
  }) {
    return SplashState(
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
