import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String? id;
  final String? name;
  final bool? isDone;
  final String? projectId;

  const TaskEntity(
    this.id,
    this.name,
    this.isDone,
    this.projectId,
  );

  @override
  List<Object?> get props => [
        id,
        name,
        isDone,
        projectId,
      ];
}
