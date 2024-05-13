import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  @override
  const TaskModel({
    int? id,
    String? name,
    bool? isDone,
    int? projectId,
  }) : super(
          id,
          name,
          isDone,
          projectId,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      name: json['name'],
      isDone: json['is_done'],
      projectId: json['project_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "is_done": isDone,
      "project_id": projectId,
    };
  }
}
