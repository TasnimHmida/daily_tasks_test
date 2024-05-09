import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'core/utils/constants.dart';
import 'features/authentication/presentation/pages/splash_screen.dart';
import 'package:daily_tasks_test/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final supabase =
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(ScreenUtilInit(
    designSize: const Size(428, 936),
    builder: (BuildContext context, Widget? child) {
      return const MyApp();
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DayTask',
      home: SplashScreen(),
    );
  }
}
