import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ebonyClay,
      body: Center(
          child: Text('homePage', style: TextStyle(color: Colors.white))),
    );
  }

// Widget _buildBody() {
// return Center(
//   child: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
//     if (state.error.isNotEmpty) {
//       showSnackBar(context, state.error, goldenRod.withOpacity(0.8));
//     }
//     else if (state.success) {
//       print('success');
//       // Navigator.of(context).pushReplacement(
//       //     MaterialPageRoute(builder: (_) => const HomePage()));
//     }
//   }, builder: (context, state) {
//     return LoginWidget(
//         isLoading: state.isLoading,
//         loginFunction: (email, password) {
//           BlocProvider.of<LoginBloc>(context).add(LoginUserEvent(
//             email: email,
//             password: password,
//           ));
//         });
//   }),
// );
// }
}
