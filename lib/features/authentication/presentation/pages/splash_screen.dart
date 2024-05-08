import 'package:flutter/material.dart';
import '../widgets/splash_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return
        // BlocProvider(
        // create: (context) =>
        // di.sl<SplashPageBloc>()..add(CheckIfUserIsLoggedInEvent()),
        // child:
        _buildBody()
        // )
        ;
  }

  Widget _buildBody() {
    return const Center(
      child:
      // BlocConsumer<SplashPageBloc, SplashPageState>(
      //     listener: (context, state) {
      //   if (state is NavigateToHomeScreenState) {
      //     if (mounted) {
      //       Timer(const Duration(seconds: 3), () {
      //         if (mounted) {
      //           Navigator.of(context)
      //               .pushReplacement(MaterialPageRoute(builder: (_) {
      //             return const HomePage();
      //           }));
      //         }
      //       });
      //     }
      //   }
      // }, builder: (context, state) {
      //   return
          SplashWidget()
      // ;}),
    );
  }
}
