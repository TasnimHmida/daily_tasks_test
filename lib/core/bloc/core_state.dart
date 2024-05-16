part of 'core_bloc.dart';

class CoreState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;
  final bool isLogoutSuccess;
  final List<ProjectModel>? projects;

  const CoreState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
    this.isLogoutSuccess = false,
    this.projects,
  });

  CoreState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
    bool? isLogoutSuccess,
    List<ProjectModel>? projects,
  }) {
    return CoreState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
      isLogoutSuccess: isLogoutSuccess ?? this.isLogoutSuccess,
      projects: projects ?? this.projects,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        success,
        isLogoutSuccess,
        projects,
      ];
}
