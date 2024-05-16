part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;
  final UserModel? user;

  const ProfileState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
    this.user,
  });

  ProfileState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
    UserModel? user,
  }) {
    return ProfileState(
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
