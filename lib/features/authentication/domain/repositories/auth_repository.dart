import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login(String email, String password);
  Future<Either<Failure, Unit>> register(String email, String password, String userName);
  Future<Either<Failure, UserModel>> getUserInfo();
  Future<Either<Failure, Unit>> signOut();
}
