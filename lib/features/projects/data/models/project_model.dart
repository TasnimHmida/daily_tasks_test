import '../../../manage_user/data/models/user_model.dart';
import '../../domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  @override
  const ProjectModel({
    int? id,
    String? name,
    String? details,
    String? time,
    String? date,
    double? percentage,
    String? userId,
    List<UserModel>? members,
  }) : super(
    id,
          name,
          details,
          time,
          date,
          percentage,
    userId,
    members,
        );

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? membersJson = json['members'];
    List<UserModel> membersList = [];

    if (membersJson != null) {
      membersJson.forEach((memberId, memberPicture) {
        UserModel member = UserModel(
          userId: memberId,
          profilePicture: memberPicture,
        );

        membersList.add(member);
      });
    }
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      details: json['details'],
      time: json['time'] ?? '',
      date: json['date'] ?? '',
      userId: json['user_id'] ?? '',
      members: membersList,
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
      "members": members,
    };
  }
}
