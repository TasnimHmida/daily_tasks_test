import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../repositories/user_repository.dart';

class GetAllUsersUseCase {
  final UserRepository repository;

  GetAllUsersUseCase({required this.repository});

  Future<Either<Failure, List<UserModel>>> call() async {
    return await repository.getAllUsers();
  }
}
