import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;
import '../bloc/notifications_bloc/notifications_bloc.dart';
import '../widgets/notifications_widget.dart';

class NotificationsPage extends StatefulWidget {
  final Function() goBackToHomeScreenFunc;

  const NotificationsPage({super.key, required this.goBackToHomeScreenFunc});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.sl<NotificationsBloc>()..add(GetNotificationsEvent()),
      child: Scaffold(backgroundColor: ebonyClay, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Center(
      child: BlocConsumer<NotificationsBloc, NotificationsState>(
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
          child: NotificationsWidget(
            notifications: state.notifications ?? [],
            goBackToHomeScreenFunc: widget.goBackToHomeScreenFunc,
          ),
        );
      }),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<NotificationsBloc>(context).add(GetNotificationsEvent());
  }
}
