import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;
import '../bloc/add_project_bloc/add_project_bloc.dart';
import '../widgets/add_project_widget.dart';

class AddProjectPage extends StatefulWidget {
  final Function() returnNavBarFunc;
  final Function() refreshFunc;

  const AddProjectPage({super.key, required this.returnNavBarFunc, required this.refreshFunc});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AddProjectBloc>(),
      child: Scaffold(backgroundColor: ebonyClay, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<AddProjectBloc, AddProjectState>(
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
          child: AddProjectWidget(
              returnNavBarFunc: widget.returnNavBarFunc,
              isLoading: state.isLoading,
              addProjectFunction: (project) {
                BlocProvider.of<AddProjectBloc>(context)
                    .add(CreateProjectEvent(project: project));
              }),
        );
      },
    );
  }
}
