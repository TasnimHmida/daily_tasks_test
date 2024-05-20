import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../manage_user/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> getUserInfo();
  Future<Either<Failure, List<UserModel>>> getAllUsers();
}
