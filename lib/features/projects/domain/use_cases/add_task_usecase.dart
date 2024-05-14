import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/project_model.dart';
import '../../data/models/task_model.dart';
import '../repositories/projects_repository.dart';

class AddTaskUseCase {
  final ProjectsRepository repository;
  AddTaskUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(TaskModel task) async {
    return await repository.addTask(task);
  }
}
