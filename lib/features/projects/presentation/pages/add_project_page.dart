import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;

import '../../../authentication/data/models/user_model.dart';
import '../../data/models/project_model.dart';
import '../widgets/add_project_widget.dart';
import '../widgets/home_widget.dart';

class AddProjectPage extends StatefulWidget {
  final Function() returnNavBarFunc;
  const AddProjectPage({super.key,required this.returnNavBarFunc});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: ebonyClay, body: _buildBody());
  }

  Widget _buildBody() {
    return Center(
        child: AddProjectWidget(returnNavBarFunc: widget.returnNavBarFunc),
        );
  }
}
