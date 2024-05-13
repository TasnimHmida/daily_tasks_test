part of 'add_project_bloc.dart';

abstract class AddProjectEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateProjectEvent extends AddProjectEvent {
  final ProjectModel project;

  CreateProjectEvent({
    required this.project,
  });

  @override
  List<Object> get props => [
        project,
      ];
}
