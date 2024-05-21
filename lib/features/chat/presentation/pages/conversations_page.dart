import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;
import '../../../manage_user/data/models/user_model.dart';
import '../bloc/conversations_bloc/conversations_bloc.dart';
import '../widgets/conversations_widget.dart';

class ConversationsPage extends StatefulWidget {
  final Function() goBackToHomeScreenFunc;

  const ConversationsPage({super.key, required this.goBackToHomeScreenFunc});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.sl<ConversationsBloc>()..add(GetConversationsEvent()),
      child: Scaffold(backgroundColor: ebonyClay, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Center(
      child: BlocConsumer<ConversationsBloc, ConversationsState>(
          listener: (context, state) {
        if (state.error.isNotEmpty) {
          showSnackBar(context, state.error, goldenRod.withOpacity(0.8));
        }
      }, builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator(
              backgroundColor: lynch, color: goldenRod);
        }
        return RefreshIndicator(
          backgroundColor: lynch,
          color: goldenRod,
          onRefresh: () => _onRefresh(context),
          child: ConversationsWidget(
              conversations: state.conversations ?? [],
              goBackToHomeScreenFunc: widget.goBackToHomeScreenFunc,
              refreshFunc: () {
                BlocProvider.of<ConversationsBloc>(context)
                    .add(GetConversationsEvent());
              }),
        );
      }),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<ConversationsBloc>(context).add(GetConversationsEvent());
  }
}
