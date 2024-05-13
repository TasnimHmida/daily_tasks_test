import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String? name;
  final bool? isDone;
  final int? projectId;

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
