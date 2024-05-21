import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;
import '../../../manage_user/data/models/user_model.dart';
import '../bloc/conversations_bloc/conversations_bloc.dart';
import '../widgets/conversations_widget.dart';
import '../widgets/create_new_conversation_widget.dart';

class CreateNewConversationPage extends StatefulWidget {
  const CreateNewConversationPage({
    super.key,
  });

  @override
  State<CreateNewConversationPage> createState() =>
      _CreateNewConversationPageState();
}

class _CreateNewConversationPageState extends State<CreateNewConversationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.sl<ConversationsBloc>()..add(CreateConversationUsersEvent()),
      child: Scaffold(backgroundColor: ebonyClay, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Center(
      child: BlocConsumer<ConversationsBloc, ConversationsState>(
          listener: (context, state) {
        if (state.error.isNotEmpty) {
          showSnackBar(context, state.error, goldenRod.withOpacity(0.8));
        } else if (state.success) {
          print('success 💃🏻💃🏻💃🏻');
          // showSnackBar(
          //     context, 'Updated successfully', goldenRod.withOpacity(0.8));
        }
      }, builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator(
              backgroundColor: lynch, color: goldenRod);
        }
        return CreateNewConversationWidget(
            users: state.users ?? [],
            createConversationFunc: (UserModel user) {
              BlocProvider.of<ConversationsBloc>(context)
                  .add(CreateConversationEvent(userTwo: user));
            }
            // isLoading: state.isLoading,
            );
      }),
    );
  }
}
