import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import '../../../projects/presentation/pages/home_page.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../widgets/login_widget.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => di.sl<LoginBloc>(),
        child: Scaffold(
          backgroundColor: ebonyClay,
          body: _buildBody(),
        ));
  }

  Widget _buildBody() {
    return Center(
      child: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
        if (state.error.isNotEmpty) {
          showSnackBar(context, state.error, goldenRod.withOpacity(0.8));
        }
        else if (state.success) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomePage()));
        }
      }, builder: (context, state) {
        return LoginWidget(
            isLoading: state.isLoading,
            loginFunction: (email, password) {
              BlocProvider.of<LoginBloc>(context).add(LoginUserEvent(
                email: email,
                password: password,
              ));
            });
      }),
    );
  }
}
