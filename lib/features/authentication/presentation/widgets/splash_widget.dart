import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../projects/presentation/pages/home_page.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../pages/login_page.dart';

class SplashWidget extends StatefulWidget {
  final bool isUserLogged;
  final UserModel? user;
  final bool isButtonDisabled;

  const SplashWidget({super.key, required this.isUserLogged, required this.user, required this.isButtonDisabled});

  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ebonyClay,
      body: SafeArea(
          child: Padding(
        padding: pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 95.w,
                child: Column(children: [
                  Align(
                      child: SvgPicture.asset('assets/icons/app_logo.svg',
                          height: 47.h)),
                  Row(
                    children: [
                      Text(
                        "Day",
                        style: TextStyle(
                          fontFamily: 'PilatExtended',
                          fontSize: 16.26.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Task",
                        style: TextStyle(
                          fontFamily: 'PilatExtended',
                          fontSize: 16.26.sp,
                          fontWeight: FontWeight.w600,
                          color: goldenRod,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            Container(
              height: 330.h,
              width: 369.w,
              decoration: const BoxDecoration(color: Colors.white),
              child: SvgPicture.asset(
                'assets/images/splash_screen_image.svg',
                height: 313.h,
                width: 321.w,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Manage\nyour\nTask with",
                  style: TextStyle(
                      fontFamily: 'PilatExtended',
                      fontSize: 61.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1),
                ),
                Text(
                  "DayTask",
                  style: TextStyle(
                      fontFamily: 'PilatExtended',
                      fontSize: 61.sp,
                      fontWeight: FontWeight.w600,
                      color: goldenRod,
                      height: 1),
                ),
              ],
            ),
            MainButton(
                buttonFunction: () {
                  if(widget.isButtonDisabled){
                    return ;
                  }else {
                    Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (_) {
                    return widget.isUserLogged
                        ? BottomNavBar(user: widget.user!)
                        : const LoginPage();
                  }));
                  }
                },
                text: "Let's Start")
          ],
        ),
      )),
    );
  }
}
