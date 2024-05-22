import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/message_model.dart';
import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(String content, String conversationId) async {
    return await repository.sendMessage(content, conversationId);
  }
}
