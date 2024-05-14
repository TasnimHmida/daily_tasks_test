import '../../domain/entities/project_entity.dart';

class ProjectModel extends TaskEntity {
  @override
  const ProjectModel({
    int? id,
    String? name,
    String? details,
    String? time,
    String? date,
    double? percentage,
    String? userId,
  }) : super(
    id,
          name,
          details,
          time,
          date,
          percentage,
    userId,
        );

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      details: json['details'],
      time: json['time'] ?? '',
      date: json['date'] ?? '',
      userId: json['user_id'] ?? '',
      percentage: double.parse((json['completed_percentage'] ?? 0).toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "details": details,
      "time": time,
      "date": date,
      "completed_percentage": percentage,
      "user_id": userId,
    };
  }
}
