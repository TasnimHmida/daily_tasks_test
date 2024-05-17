import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/project_model.dart';
import '../../data/models/task_model.dart';
import '../repositories/projects_repository.dart';

class UpdateTaskUseCase {
  final ProjectsRepository repository;
  UpdateTaskUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(TaskModel task, double percentage) async {
    return await repository.updateTask(task, percentage);
  }
}
