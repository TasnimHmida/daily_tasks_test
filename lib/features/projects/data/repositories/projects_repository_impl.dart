import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/projects_repository.dart';
import '../data_sources/projects_remote_data_source.dart';
import '../models/project_model.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  final ProjectsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProjectsRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<ProjectModel>>> getAllProjects() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await remoteDataSource.getAllProjects();
        return Right(remoteResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createProject(ProjectModel project) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await remoteDataSource.createProject(project);
        return Right(remoteResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
  @override
  Future<Either<Failure, Unit>> updateProject(ProjectModel project) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await remoteDataSource.updateProject(project);
        return Right(remoteResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

}
