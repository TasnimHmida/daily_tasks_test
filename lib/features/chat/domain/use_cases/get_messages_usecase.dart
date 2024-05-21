import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../../data/models/conversation_model.dart';
import '../../data/models/message_model.dart';
import '../repositories/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository repository;
  GetMessagesUseCase({required this.repository});

  Future<Either<Failure, List<MessageModel>>> call(String conversationId) async {
    return await repository.getMessages(conversationId);
  }
}
