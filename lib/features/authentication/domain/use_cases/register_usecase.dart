import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(
      {required String userName,
      required String email,
      required String password}) async {
    return await repository.register(
        userName: userName, email: email, password: password);
  }
}
