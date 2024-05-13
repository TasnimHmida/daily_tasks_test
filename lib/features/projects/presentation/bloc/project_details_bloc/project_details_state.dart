part of 'project_details_bloc.dart';

class ProjectDetailsState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;
  final ProjectModel? project;
  final List<TaskModel>? tasks;

  const ProjectDetailsState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
    this.project,
    this.tasks,
  });

  ProjectDetailsState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
    ProjectModel? project,
    List<TaskModel>? tasks,
  }) {
    return ProjectDetailsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
      project: project ?? this.project,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        success,
        project,
        tasks,
      ];
}
