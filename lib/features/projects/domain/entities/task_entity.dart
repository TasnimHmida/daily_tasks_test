import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String? name;
  final bool? isDone;
  final int? projectId;
  final String? userId;

  const TaskEntity(
    this.id,
    this.name,
    this.isDone,
    this.projectId,
    this.userId,
  );

  @override
  List<Object?> get props => [
        id,
        name,
        isDone,
        projectId,
        userId,
      ];
}
