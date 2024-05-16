import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../authentication/data/models/user_model.dart';
import '../repositories/profile_repository.dart';

class UpdateUserUseCase {
  final ProfileRepository repository;
  UpdateUserUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(UserModel user, File? image) async {
    return await repository.updateUser(user, image);
  }
}
