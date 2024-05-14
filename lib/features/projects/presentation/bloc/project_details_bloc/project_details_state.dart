part of 'project_details_bloc.dart';

class ProjectDetailsState extends Equatable {
  final bool isLoading;
  final bool isTasksLoading;
  final String error;
  final bool success;
  final ProjectModel? project;
  final List<TaskModel>? tasks;

  const ProjectDetailsState({
    this.isLoading = false,
    this.isTasksLoading = false,
    this.error = "",
    this.success = false,
    this.project,
    this.tasks,
  });

  ProjectDetailsState copyWith({
    bool? isLoading,
    bool? isTasksLoading,
    String? error,
    bool? success,
    ProjectModel? project,
    List<TaskModel>? tasks,
  }) {
    return ProjectDetailsState(
      isLoading: isLoading ?? this.isLoading,
      isTasksLoading: isTasksLoading ?? this.isTasksLoading,
      error: error ?? this.error,
      success: success ?? this.success,
      project: project ?? this.project,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
    isTasksLoading,
        error,
        success,
        project,
        tasks,
      ];
}
