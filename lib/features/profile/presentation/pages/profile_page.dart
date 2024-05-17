import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;
import '../../../manage_user/data/models/user_model.dart';
import '../bloc/profile_bloc/profile_bloc.dart';
import '../widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  final Function() logoutFunc;
  final Function() refreshUserFunc;
  const ProfilePage({
    super.key, required this.logoutFunc, required this.refreshUserFunc,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ProfileBloc>()..add(GetProfileInfoEvent()),
      child: Scaffold(backgroundColor: ebonyClay, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Center(
      child:
          BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
        if (state.error.isNotEmpty) {
          showSnackBar(context, state.error, goldenRod.withOpacity(0.8));
        } else if (state.success) {
          widget.refreshUserFunc();
          showSnackBar(
              context, 'Updated successfully', goldenRod.withOpacity(0.8));
        }
      }, builder: (context, state) {
        if (state.isLoading || state.user == null) {
          return const CircularProgressIndicator(
              backgroundColor: lynch, color: goldenRod);
        }
        return ProfileWidget(
            user: state.user ?? const UserModel(),
            // isLoading: state.isLoading,
            logoutFunc: widget.logoutFunc,
            refreshUserFunc: widget.refreshUserFunc,
            editFunction: (user, image) {
              BlocProvider.of<ProfileBloc>(context)
                  .add(EditProfileEvent(user: user, image: image));
            });
      }),
    );
  }
}
