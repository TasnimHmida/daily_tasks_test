import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;

import '../../../manage_user/data/models/user_model.dart';
import '../../data/models/project_model.dart';
import '../widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  final List<ProjectModel> projects;
  final UserModel user;
  final Function() refreshFunc;
  final Function() refreshUserFunc;
  final Function() logoutFunc;
  const HomePage({super.key, required this.projects, required this.user,required this.refreshFunc, required this.logoutFunc, required this.refreshUserFunc});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: ebonyClay, body: _buildBody(widget.projects));
  }

  Widget _buildBody(List<ProjectModel> projects) {
    return Center(
        child: HomeWidget(projects: projects, user: widget.user, refreshFunc: widget.refreshFunc, logoutFunc: widget.logoutFunc,refreshUserFunc: widget.refreshUserFunc),
        );
  }
}
