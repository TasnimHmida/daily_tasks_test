import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_theme.dart';

class MainButton extends StatefulWidget {
  final String text;
  final bool isLoading;
  final Function() buttonFunction;

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
        height: 67.sp,
        child: TextButton(
          onPressed: () {
            widget.buttonFunction;
          },
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              padding: const EdgeInsets.all(0.0), backgroundColor: goldenRod),
          child: Container(
            alignment: Alignment.center,
            child: widget.isLoading
                ? const CircularProgressIndicator(
                    color: ebonyClay,
                  )
                : Text(
                    widget.text,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: ebonyClay,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
          ),
        ));
  }
}
