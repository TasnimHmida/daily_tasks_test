import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;
import '../../data/models/project_model.dart';
import '../bloc/add_edit_project_bloc/add_edit_project_bloc.dart';
import '../widgets/add_or_edit_project_widget.dart';

class AddOrEditProjectPage extends StatefulWidget {
  final ProjectModel? project;
  final Function() returnNavBarFunc;
  final Function() refreshFunc;

  const AddOrEditProjectPage(
      {super.key,
      required this.returnNavBarFunc,
      required this.refreshFunc,
      this.project});

  @override
  State<AddOrEditProjectPage> createState() => _AddOrEditProjectPageState();
}

class _AddOrEditProjectPageState extends State<AddOrEditProjectPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AddEditProjectBloc>(),
      child: Scaffold(backgroundColor: ebonyClay, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<AddEditProjectBloc, AddEditProjectState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          showSnackBar(context, state.error, goldenRod.withOpacity(0.8));
        } else if (state.success) {
          widget.returnNavBarFunc();
          widget.refreshFunc();
        }
      },
      builder: (context, state) {
        return Center(
          child: AddOrEditProjectWidget(
              returnNavBarFunc: widget.returnNavBarFunc,
              isLoading: state.isLoading,
              addOrEditProjectFunction: (project) {
                BlocProvider.of<AddEditProjectBloc>(context).add(
                    widget.project != null
                        ? EditProjectEvent(
                            project: ProjectModel(
                                name: project.name,
                                details: project.details,
                                date: project.date,
                                time: project.time,
                                id: widget.project!.id,
                                userId: widget.project!.userId))
                        : CreateProjectEvent(project: project));
              },
              project: widget.project),
        );
      },
    );
  }
}
