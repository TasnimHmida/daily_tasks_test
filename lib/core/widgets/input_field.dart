import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../app_theme.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  late void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final String prefixIcon;
  final bool isPassword;

  InputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.prefixIcon = 'assets/icons/ic_calendar.svg',
    FocusNode? focusNode,
    this.isPassword = false,
  });

  @override
  State<InputField> createState() => _TextFormFieldWidget();
}

class _TextFormFieldWidget extends State<InputField> {
  bool show = false;
  bool hidePassword = true;
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.hintText,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: nepal,
            )),
        SizedBox(height: 10.h),
        TextFormField(
          controller: widget.controller,
          cursorColor: Colors.white,
          obscureText: widget.isPassword
              ? hidePassword
                  ? true
                  : false
              : false,
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          style: TextStyle(
            fontFamily: "Inter",
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18.sp,
            letterSpacing: widget.isPassword ? 1 : 0,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // showCursor: widget.showCursor,
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true, // Set filled to true
            fillColor: fiord, //
            hintStyle: TextStyle(
                fontFamily: "Inter",
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp),
            errorStyle: TextStyle(
                fontFamily: "Inter",
                color: const Color(0xffF04438),
                fontWeight: FontWeight.w400,
                fontSize: 16.sp),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: goldenRod),
            ),
            prefixIcon: IconButton(
              icon: SvgPicture.asset(
                widget.prefixIcon,
                height: 24.h,
              ),
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/hide_password_icon.svg',
                      height: 24.h,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  )
                : null,
          ),
          validator: widget.validator,
          // keyboardType: widget.inputType!,
        ),
      ],
    );
  }
}
