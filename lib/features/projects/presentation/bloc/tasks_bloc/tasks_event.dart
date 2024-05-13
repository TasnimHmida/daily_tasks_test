part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProjectTasksEvent extends TasksEvent {
  final String projectId;

  GetProjectTasksEvent({
    required this.projectId,
  });

  @override
  List<Object> get props => [
        projectId,
      ];
}
