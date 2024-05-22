import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../models/conversation_model.dart';
import '../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<Unit> createConversation(UserModel userTwo);

  Future<List<ConversationModel>> getConversations();

  Future<List<MessageModel>> getMessages(String conversationId);

  Future<Unit> sendMessage(String content, String conversationId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final PrefUtils prefUtils;
  final SupabaseClient supabase;

  ChatRemoteDataSourceImpl({required this.supabase, required this.prefUtils});

  @override
  Future<List<ConversationModel>> getConversations() async {
    try {
      var user = prefUtils.getUserInfo();
      final response = await supabase.from('conversations').select().filter(
          'users',
          'cs',
          jsonEncode([
            {"user_id": user?.userId}
          ]));

      final List<ConversationModel> conversations = response
          .map<ConversationModel>((jsonModel) => ConversationModel.fromJson(
              json: jsonModel, myUserId: user?.userId ?? ''))
          .toList();

      return conversations;
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }

  @override
  Future<Unit> createConversation(
    UserModel userTwo,
  ) async {
    try {
      final UserModel? userOne = prefUtils.getUserInfo();
      await supabase.from('conversations').insert({
        "users": [
          {
            "user_id": userOne?.userId,
            "username": userOne?.userName,
            "profile_picture": userOne?.profilePicture,
          },
          {
            "user_id": userTwo.userId,
            "username": userTwo.userName,
            "profile_picture": userTwo.profilePicture,
          },
        ]
      });

      return Future.value(unit);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<MessageModel>> getMessages(String conversationId) async {
    try {
      var user = prefUtils.getUserInfo();
      final response = await supabase
          .from('messages')
          .select()
          .eq('conversation_id', conversationId);

      final List<MessageModel> messages = response
          .map<MessageModel>((jsonModel) => MessageModel.fromJson(
              json: jsonModel, myUserId: user?.userId ?? ''))
          .toList();

      return messages;
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }

  @override
  Future<Unit> sendMessage(String content, String conversationId) async {
    try {
      var user = prefUtils.getUserInfo();
      await supabase.from('messages').insert({
        "conversation_id": conversationId,
        "content": content,
        "user_id": user?.userId
      });
      await supabase.from('conversations').update({
        'last_message': content,
        'last_message_date': DateTime.now().toIso8601String(),
      }).eq('id', conversationId);

      return Future.value(unit);
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }
}
