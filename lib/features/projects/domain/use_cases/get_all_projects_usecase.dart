import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/project_model.dart';
import '../repositories/projects_repository.dart';

class GetAllProjectsUseCase {
  final ProjectsRepository repository;
  GetAllProjectsUseCase({required this.repository});

  Future<Either<Failure, List<ProjectModel>>> call() async {
    return await repository.getAllProjects();
  }
}
