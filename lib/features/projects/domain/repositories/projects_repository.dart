import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/project_model.dart';

abstract class ProjectsRepository {
  Future<Either<Failure, List<ProjectModel>>> getAllProjects();
  Future<Either<Failure, Unit>> createProject(ProjectModel project);
  Future<Either<Failure, Unit>> updateProject(ProjectModel project);
}
