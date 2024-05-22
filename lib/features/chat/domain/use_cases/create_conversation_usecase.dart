import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../repositories/chat_repository.dart';

class CreateConversationUseCase {
  final ChatRepository repository;
  CreateConversationUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(UserModel userTwo) async {
    return await repository.createConversation(userTwo);
  }
}
