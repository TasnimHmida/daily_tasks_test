import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/input_validation.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/main_button.dart';
import '../pages/login_page.dart';

class RegisterWidget extends StatefulWidget {
  final bool isLoading;
  final Function(String, String, String) registerFunction;

  const RegisterWidget({
    super.key,
    required this.isLoading,
    required this.registerFunction,
  });

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String error = '';
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              SizedBox(height: 40.h),
              SvgPicture.asset(
                'assets/icons/app_logo.svg',
                height: 71.38.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Day",
                    style: TextStyle(
                      fontFamily: 'PilatExtended',
                      fontSize: 24.3.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Task",
                    style: TextStyle(
                      fontFamily: 'PilatExtended',
                      fontSize: 24.3.sp,
                      fontWeight: FontWeight.w600,
                      color: goldenRod,
                    ),
                  ),
                ],
              ),
            ]),
            SizedBox(height: 30.h),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create your account",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10.h),
                  InputField(
                      hintText: 'Full Name',
                      prefixIcon: 'assets/icons/user_icon.svg',
                      controller: _nameController,
                      validator: (value) =>
                          validateField(value!, 'Name', context)),
                  SizedBox(height: 20.h),
                  InputField(
                      hintText: 'Email Address',
                      prefixIcon: 'assets/icons/email_icon.svg',
                      controller: _emailController,
                      validator: (value) => validateEmail(value!, context)),
                  SizedBox(height: 20.h),
                  InputField(
                    hintText: 'Password',
                    prefixIcon: 'assets/icons/password_icon.svg',
                    isPassword: true,
                    controller: _passwordController,
                    validator: (value) =>
                        validatePasswordForLogin(value!, context),
                  ),
                  SizedBox(height: 20.h),
                  Wrap(children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                          if (isChecked) {
                            error = '';
                          } else {
                            error = 'This field should be checked';
                          }
                        });
                      },
                      child: SvgPicture.asset(
                        isChecked
                            ? 'assets/icons/done_icon.svg'
                            : 'assets/icons/is_not_checked_icon.svg',
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "I have read & agreed to DayTask ",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: nepal),
                    ),
                    Text(
                      "Privacy Policy,",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: goldenRod),
                    ),
                    Text(
                      "      Terms & Condition",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: goldenRod),
                    ),
                  ]),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        constraints: const BoxConstraints(minHeight: 16.0),
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Text(
                          (error.isNotEmpty) ? ' * $error' : '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                  MainButton(
                      buttonFunction: () {
                        validateCredentialsThenRegisterUser(context);
                      },
                      text: "Sign Up",
                      isLoading: widget.isLoading),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: nepal)),
                SizedBox(
                  width: ScreenUtil().setWidth(10.w),
                ),
                GestureDetector(
                  onTap: () {
                    navigateToLoginScreen();
                  },
                  child: Text("Log In",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: goldenRod,
                      )),
                ),
                SizedBox(height: 150.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void validateCredentialsThenRegisterUser(context) async {
    final isValid = _formKey.currentState!.validate();
    if (!isChecked) {
      setState(() {
        error = 'This field should be checked';
      });
      return;
    }
    if (isValid) {
      final String name;
      final String email;
      final String password;

      name = _nameController.text;
      email = _emailController.text;
      password = _passwordController.text;

      widget.registerFunction(name, email, password);
    }
  }

  navigateToLoginScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }

  navigateToHomePage() {
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //   return const HomePage();
    // }));
  }
}
