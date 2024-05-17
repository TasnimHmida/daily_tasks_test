import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;

import '../../../manage_user/data/models/user_model.dart';
import '../../data/models/project_model.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/home_widget.dart';

class CalendarPage extends StatefulWidget {
  final List<ProjectModel> projects;
  final Function() goBackToHomeScreenFunc;
  final Function() goToAddProjectScreenFunc;
  final Function() refreshFunc;

  const CalendarPage({
    super.key,
    required this.projects,
    required this.goBackToHomeScreenFunc,
    required this.goToAddProjectScreenFunc,
    required this.refreshFunc,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ebonyClay, body: _buildBody(widget.projects));
  }

  Widget _buildBody(List<ProjectModel> projects) {
    return Center(
      child: CalendarWidget(
        projects: projects,
        goBackToHomeScreenFunc: widget.goBackToHomeScreenFunc,
        goToAddProjectScreenFunc: widget.goToAddProjectScreenFunc,
        refreshFunc: widget.refreshFunc,
      ),
    );
  }
}
