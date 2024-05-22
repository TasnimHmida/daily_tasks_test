import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../../data/models/conversation_model.dart';
import '../../data/models/message_model.dart';

abstract class ChatRepository {
  Future<Either<Failure, Unit>> createConversation(UserModel userTwo);

  Future<Either<Failure, List<ConversationModel>>> getConversations();

  Future<Either<Failure, List<MessageModel>>> getMessages(
      String conversationId);

  Future<Either<Failure, Unit>> sendMessage(String content, String conversationId);
}
