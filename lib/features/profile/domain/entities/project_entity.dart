import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String? name;
  final String? details;
  final String? time;
  final String? date;
  final double? percentage;
  final String? userId;

  const TaskEntity(
    this.id,
    this.name,
    this.details,
    this.time,
    this.date,
    this.percentage,
    this.userId,
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
      ];
}
