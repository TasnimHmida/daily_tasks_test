part of 'core_bloc.dart';

class CoreState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;
  final List<ProjectModel>? projects;

  const CoreState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
    this.projects,
  });

  CoreState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
    List<ProjectModel>? projects,
  }) {
    return CoreState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
      projects: projects ?? this.projects,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        success,
        projects,
      ];
}
