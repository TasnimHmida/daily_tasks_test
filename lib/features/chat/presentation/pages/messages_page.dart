import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;
import '../../../manage_user/data/models/user_model.dart';
import '../../data/models/message_model.dart';
import '../bloc/conversations_bloc/conversations_bloc.dart';
import '../bloc/messages_bloc/messages_bloc.dart';
import '../widgets/conversations_widget.dart';
import '../widgets/messages_widget.dart';

class MessagesPage extends StatefulWidget {
  final String conversationId;
  final UserModel contact;

  const MessagesPage(
      {super.key, required this.conversationId, required this.contact});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<MessagesBloc>()
        ..add(GetMessagesEvent(conversationId: widget.conversationId)),
      child: Scaffold(backgroundColor: ebonyClay, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Center(
      child:
          BlocConsumer<MessagesBloc, MessagesState>(listener: (context, state) {
        if (state.error.isNotEmpty) {
          showSnackBar(context, state.error, goldenRod.withOpacity(0.8));
        } else if (state.success) {
          BlocProvider.of<MessagesBloc>(context)
              .add(RefreshMessagesEvent(conversationId: widget.conversationId));
        }
      }, builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator(
              backgroundColor: lynch, color: goldenRod);
        }
        return MessagesWidget(
          messages: state.messages ?? [],
          contact: widget.contact,
          sendMessageFunc: (String content) {
            BlocProvider.of<MessagesBloc>(context).add(SendMessageEvent(
                messageContent: content,
                conversationId: widget.conversationId,
                userId: widget.contact.userId ?? ''));
          },
          // isLoading: state.isLoading,
        );
      }),
    );
  }
}
