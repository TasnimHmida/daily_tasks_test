import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_theme.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ebonyClay,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/app_logo.svg', height: 47.h),
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
            SizedBox(
              height: 30.h,
            ),
            Container(
              height: 320.h,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: SvgPicture.asset(
                'assets/images/splash_screen_image.svg',
                width: 321.w,
              ),
            ),
            Text(
              "Manage\nyour\nTask with",
              style: TextStyle(
                fontFamily: 'PilatExtended',
                fontSize: 61.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              "DayTask",
              style: TextStyle(
                fontFamily: 'PilatExtended',
                fontSize: 61.sp,
                fontWeight: FontWeight.w600,
                color: goldenRod,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
