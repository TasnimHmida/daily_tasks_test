import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../repositories/user_repository.dart';

class GetUserInfoUseCase {
  final UserRepository repository;

  GetUserInfoUseCase({required this.repository});

  Future<Either<Failure, UserModel>> call() async {
    return await repository.getUserInfo();
  }
}
