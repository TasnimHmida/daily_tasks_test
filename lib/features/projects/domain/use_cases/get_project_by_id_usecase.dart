import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/project_model.dart';
import '../repositories/projects_repository.dart';

class GetProjectByIdUseCase {
  final ProjectsRepository repository;

  GetProjectByIdUseCase({required this.repository});

  Future<Either<Failure, ProjectModel>> call(String projectId) async {
    return await repository.getProjectById(projectId);
  }
}
