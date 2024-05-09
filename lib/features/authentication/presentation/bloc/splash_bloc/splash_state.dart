part of 'splash_bloc.dart';

class SplashState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;

  const SplashState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
  });

  SplashState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        success,
      ];
}
