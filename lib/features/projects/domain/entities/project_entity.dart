import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String? name;
  final String? details;
  final String? time;
  final String? date;
  final double? percentage;

  const TaskEntity(
    this.id,
    this.name,
    this.details,
    this.time,
    this.date,
    this.percentage,
  );

  @override
  List<Object?> get props => [
    id,
        name,
        details,
        time,
        date,
    percentage,
      ];
}
