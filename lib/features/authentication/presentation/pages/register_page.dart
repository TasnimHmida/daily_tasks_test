import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import '../bloc/register_bloc/register_bloc.dart';
import '../widgets/register_widget.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => di.sl<RegisterBloc>(),
        child: Scaffold(
          backgroundColor: ebonyClay,
          body: _buildBody(),
        ));
  }

  Widget _buildBody() {
    return Center(
      child:
          BlocConsumer<RegisterBloc, RegisterState>(listener: (context, state) {
        if (state.error.isNotEmpty) {
          showSnackBar(context, state.error, goldenRod.withOpacity(0.8));
        } else if (state.success) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginPage()));
          showSnackBar(context, 'User registered successfully.',
              goldenRod.withOpacity(0.8));
        }
      }, builder: (context, state) {
        return RegisterWidget(
            isLoading: state.isLoading,
            registerFunction: (name, email, password) {
              BlocProvider.of<RegisterBloc>(context).add(RegisterUserEvent(
                userName: name,
                email: email,
                password: password,
              ));
            });
      }),
    );
  }
}
