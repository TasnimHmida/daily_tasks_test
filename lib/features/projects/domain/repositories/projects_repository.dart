import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/project_model.dart';
import '../../data/models/task_model.dart';

abstract class ProjectsRepository {
  Future<Either<Failure, List<ProjectModel>>> getAllProjects();
  Future<Either<Failure, ProjectModel>> getProjectById(String projectId);
  Future<Either<Failure, List<TaskModel>>> getProjectTasks(String projectId);
  Future<Either<Failure, Unit>> createProject(ProjectModel project);
  Future<Either<Failure, Unit>> updateProject(ProjectModel project);
  Future<Either<Failure, Unit>> addTask(TaskModel task);
  Future<Either<Failure, Unit>> updateTask(TaskModel task);
}
