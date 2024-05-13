import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;
import '../../data/models/project_model.dart';
import '../bloc/project_details_bloc/project_details_bloc.dart';
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
      create: (context) => di.sl<ProjectDetailsBloc>()
        ..add(GetProjectByIdEvent(projectId: widget.project.id.toString()))
        ..add(GetProjectTasksEvent(projectId: widget.project.id.toString())),
      child: Scaffold(backgroundColor: ebonyClay, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ProjectDetailsBloc, ProjectDetailsState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          showSnackBar(context, state.error, goldenRod.withOpacity(0.8));
        } else if (state.success) {
          // widget.returnNavBarFunc();
          // widget.refreshFunc();
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
              child: CircularProgressIndicator(
                  backgroundColor: lynch, color: goldenRod));
        }
        return Center(
          child: ProjectDetailsWidget(
              project: state.project ?? widget.project,
              tasks: state.tasks ?? [],
              isLoading: state.isLoading,
            refreshFunc: (){
              BlocProvider.of<ProjectDetailsBloc>(context)
                  .add(GetProjectByIdEvent(projectId: widget.project.id.toString()));
            }
          ),
        );
      },
    );
  }
}
