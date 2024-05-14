import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/project_model.dart';
import '../repositories/projects_repository.dart';

class UpdateProjectUseCase {
  final ProjectsRepository repository;

  UpdateProjectUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(ProjectModel project) async {
    return await repository.updateProject(project);
  }
}
