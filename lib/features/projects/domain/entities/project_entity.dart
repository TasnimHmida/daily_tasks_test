import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String? name;
  final String? details;
  final String? time;
  final String? date;
  final double? percentage;

  const ProjectEntity(
    this.name,
    this.details,
    this.time,
    this.date,
    this.percentage,
  );

  @override
  List<Object?> get props => [
        name,
        details,
        time,
        date,
    percentage,
      ];
}
