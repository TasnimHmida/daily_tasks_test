import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  @override
  const TaskModel({
    String? id,
    String? name,
    bool? isDone,
    String? projectId,
  }) : super(
          id,
          name,
          isDone,
          projectId,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      name: json['name'],
      isDone: json['isDone'],
      projectId: json['projectId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "isDone": isDone,
      "projectId": projectId,
    };
  }
}
