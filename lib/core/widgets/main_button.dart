import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../app_theme.dart';

class MainButton extends StatefulWidget {
  final String text;
  final bool isLoading;
  final buttonFunction;

  const MainButton({
    super.key,
    required this.buttonFunction,
    required this.text,
    this.isLoading = false,
  });

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.text == 'Logout' ? 54.h : 67.h,
        child: TextButton(
          onPressed: widget.buttonFunction,
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              padding: const EdgeInsets.all(0.0),
              backgroundColor: goldenRod),
          child: Container(
            alignment: Alignment.center,
            child: widget.isLoading
                ? const CircularProgressIndicator(
                    color: Colors.black,
                  )
                : widget.text == 'Logout'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            SvgPicture.asset(
                              'assets/icons/logout_icon.svg',
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Logout",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: ebonyClay,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ])
                    : Text(
                        widget.text,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
          ),
        ));
  }
}
