import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/projects_repository.dart';
import '../data_sources/projects_remote_data_source.dart';
import '../models/project_model.dart';
import '../models/task_model.dart';

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
  Future<Either<Failure, ProjectModel>> getProjectById(String projectId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await remoteDataSource.getProjectById(projectId);
        return Right(remoteResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> getProjectTasks(
      String projectId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse =
            await remoteDataSource.getProjectTasks(projectId);
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
  @override
  Future<Either<Failure, Unit>> addTask(TaskModel task, double percentage) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await remoteDataSource.addTask(task, percentage);
        return Right(remoteResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
  @override
  Future<Either<Failure, Unit>> updateTask(TaskModel task, double percentage) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await remoteDataSource.updateTask(task, percentage);
        return Right(remoteResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
