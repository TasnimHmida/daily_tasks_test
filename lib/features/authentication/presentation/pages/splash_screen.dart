import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../projects/presentation/pages/home_page.dart';
import '../../data/models/user_model.dart';
import '../bloc/splash_bloc/splash_bloc.dart';
import '../widgets/splash_widget.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;

import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => di.sl<SplashBloc>()..add(GetUserEvent()),
        child: _buildBody());
  }

  Widget _buildBody() {
    return Center(
      child: BlocConsumer<SplashBloc, SplashState>(listener: (context, state) {
        if (mounted) {
          Timer(const Duration(seconds: 3), () {
            if (mounted) {
              if (state.success) {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) {
                  return BottomNavBar(user: state.user!);
                }));
              }
              if (state.error.isNotEmpty) {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) {
                  return const LoginPage();
                }));
              }
            }
          });
        }
      }, builder: (context, state) {
        return SplashWidget(
            isUserLogged: state.success,
            user: state.user,
            isButtonDisabled: state.user == null);
      }),
    );
  }
}
