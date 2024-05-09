import '../../domain/entities/project_entity.dart';
class ProjectModel extends ProjectEntity {
  @override
  const ProjectModel({
    String? name,
    String? details,
    String? time,
    String? date,
  }) : super(
          name,
          details,
          time,
          date,
        );

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      name: json['name'],
      details: json['details'],
      time: json['time'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "details": details,
      "time": time,
      "date": date,
    };
  }
}
