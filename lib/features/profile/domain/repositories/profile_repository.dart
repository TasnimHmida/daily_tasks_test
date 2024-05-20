import 'dart:io';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../manage_user/data/models/user_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Unit>> updateUser(UserModel user, File? image);
}
