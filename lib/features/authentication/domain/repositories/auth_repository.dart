import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login(String email, String password);

  Future<Either<Failure, Unit>> register(String email, String password, String userName);
  Future<Either<Failure, Unit>> signOut();

}
