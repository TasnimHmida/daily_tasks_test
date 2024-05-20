import 'package:equatable/equatable.dart';

import '../../../manage_user/data/models/user_model.dart';

class ProjectEntity extends Equatable {
  final int? id;
  final String? name;
  final String? details;
  final String? time;
  final String? date;
  final double? percentage;
  final String? userId;
  final List<UserModel>? members;

  const ProjectEntity(
    this.id,
    this.name,
    this.details,
    this.time,
    this.date,
    this.percentage,
    this.userId,
    this.members,
  );

  @override
  List<Object?> get props => [
        id,
        name,
        details,
        time,
        date,
        percentage,
        userId,
    members,
      ];
}
