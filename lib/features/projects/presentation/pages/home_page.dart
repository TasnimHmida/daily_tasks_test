import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;

import '../widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: ebonyClay, body: _buildBody());
  }

  Widget _buildBody() {
    return const Center(
        child:
            // BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
            //   if (state.error.isNotEmpty) {
            //     showSnackBar(context, state.error, goldenRod.withOpacity(0.8));
            //   } else if (state.success) {
            //     print('success');
            //     // Navigator.of(context).pushReplacement(
            //     //     MaterialPageRoute(builder: (_) => const HomePage()));
            //   }
            // }, builder: (context, state) {
            //   return
            HomeWidget()
        // ;}),
        );
  }
}
