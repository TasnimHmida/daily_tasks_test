import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/project_model.dart';
import '../../data/models/task_model.dart';
import '../repositories/projects_repository.dart';

class GetProjectTasksUseCase {
  final ProjectsRepository repository;

  GetProjectTasksUseCase({required this.repository});

  Future<Either<Failure, List<TaskModel>>> call(String projectId) async {
    return await repository.getProjectTasks(projectId);
  }
}
