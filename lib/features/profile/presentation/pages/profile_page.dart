import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;
import '../../../authentication/data/models/user_model.dart';
import '../../../projects/presentation/widgets/home_widget.dart';
import '../../data/models/project_model.dart';
import '../widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: ebonyClay, body: _buildBody());
  }

  Widget _buildBody() {
    return Center(
        child: ProfileWidget(),
        );
  }
}
