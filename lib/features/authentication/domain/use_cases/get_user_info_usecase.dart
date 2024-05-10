import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class GetUserInfoUseCase {
  final AuthRepository repository;

  GetUserInfoUseCase({required this.repository});

  Future<Either<Failure, UserModel>> call() async {
    return await repository.getUserInfo();
  }
}
