import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../../data/models/conversation_model.dart';
import '../repositories/chat_repository.dart';

class GetConversationsUseCase {
  final ChatRepository repository;
  GetConversationsUseCase({required this.repository});

  Future<Either<Failure, List<ConversationModel>>> call() async {
    return await repository.getConversations();
  }
}
