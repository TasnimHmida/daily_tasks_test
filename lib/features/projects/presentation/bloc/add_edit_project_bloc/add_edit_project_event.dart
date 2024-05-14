part of 'add_edit_project_bloc.dart';

abstract class AddEditProjectEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateProjectEvent extends AddEditProjectEvent {
  final ProjectModel project;

  CreateProjectEvent({
    required this.project,
  });

  @override
  List<Object> get props => [
        project,
      ];
}
class EditProjectEvent extends AddEditProjectEvent {
  final ProjectModel project;

  EditProjectEvent({
    required this.project,
  });

  @override
  List<Object> get props => [
        project,
      ];
}
