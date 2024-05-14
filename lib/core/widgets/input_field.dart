import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../app_theme.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String? inputTitle;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  late void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final String? prefixIcon;
  final int? maxLines;
  final bool isPassword;
  final bool isEdit;

  InputField({
    super.key,
    required this.controller,
    this.hintText,
    this.inputTitle,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.prefixIcon,
    this.maxLines,
    FocusNode? focusNode,
    this.isPassword = false,
    this.isEdit = false,
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
        widget.inputTitle != null
            ? Column(
                children: [
                  Text(widget.inputTitle!,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: nepal,
                      )),
                  SizedBox(height: 10.h),
                ],
              )
            : Container(),
        TextFormField(
          controller: widget.controller,
          cursorColor: Colors.white,
          obscureText: widget.isPassword
              ? hidePassword
                  ? true
                  : false
              : false,
          maxLines: widget.maxLines ?? 1,
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
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            // Set filled to true
            fillColor: fiord,
            //
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
            enabledBorder: InputBorder.none,
            prefixIcon: widget.prefixIcon != null
                ? IconButton(
                    icon: SvgPicture.asset(
                      widget.prefixIcon!,
                      height: 24.h,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  )
                : null,
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
                : widget.isEdit
                    ? IconButton(
                        icon: SvgPicture.asset('assets/icons/edit_icon.svg',
                            height: 24.h, color: nepal),
                        onPressed: () {},
                      )
                    : null,
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
