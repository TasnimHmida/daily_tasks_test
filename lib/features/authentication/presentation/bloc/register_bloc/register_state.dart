part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;

  const RegisterState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
  });

  RegisterState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
  }) {
    return RegisterState(
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
