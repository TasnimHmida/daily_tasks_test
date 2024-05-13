import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;
import '../../data/models/project_model.dart';
import '../bloc/add_project_bloc/add_project_bloc.dart';
import '../bloc/tasks_bloc/tasks_bloc.dart';
import '../widgets/project_details_widget.dart';

class ProjectDetailsPage extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<TasksBloc>()
        ..add(GetProjectTasksEvent(projectId: widget.project.id.toString())),
      child: Scaffold(backgroundColor: ebonyClay, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          showSnackBar(context, state.error, goldenRod.withOpacity(0.8));
        } else if (state.success) {
          // widget.returnNavBarFunc();
          // widget.refreshFunc();
        }
      },
      builder: (context, state) {
        return Center(
          child: ProjectDetailsWidget(
              project: widget.project, tasks: state.tasks ?? [], isLoading: state.isLoading),
        );
      },
    );
  }
}
