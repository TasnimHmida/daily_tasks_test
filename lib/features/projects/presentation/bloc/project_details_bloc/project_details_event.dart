part of 'project_details_bloc.dart';

abstract class ProjectDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProjectByIdEvent extends ProjectDetailsEvent {
  final String projectId;

  GetProjectByIdEvent({
    required this.projectId,
  });

  @override
  List<Object> get props => [
        projectId,
      ];
}

class GetProjectTasksEvent extends ProjectDetailsEvent {
  final String projectId;

  GetProjectTasksEvent({
    required this.projectId,
  });

  @override
  List<Object> get props => [
        projectId,
      ];
}

class AddTaskEvent extends ProjectDetailsEvent {
  final TaskModel task;
  final double percentage;

  AddTaskEvent({
    required this.task,
    required this.percentage,
  });

  @override
  List<Object> get props => [
        task,
        percentage,
      ];
}

class UpdateTaskEvent extends ProjectDetailsEvent {
  final TaskModel task;
  final double percentage;

  UpdateTaskEvent({
    required this.task,
    required this.percentage,
  });

  @override
  List<Object> get props => [
        task,
        percentage,
      ];
}
