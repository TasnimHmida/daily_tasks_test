import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/input_validation.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/main_button.dart';
import '../pages/register_page.dart';

class LoginWidget extends StatefulWidget {
  final bool isLoading;
  final Function(String, String) loginFunction;

  const LoginWidget(
      {super.key, required this.isLoading, required this.loginFunction});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    "Welcome Back!",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10.h),
                  InputField(
                      hintText: 'Email Address',
                      isPassword: false,
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
                  SizedBox(height: 60.h),
                  MainButton(
                      buttonFunction: () {
                        validateCredentialsThenLoginUser(context);
                      },
                      text: "Log In",
                      isLoading: widget.isLoading),
                ],
              ),
            ),
            SizedBox(height: 100.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don’t have an account?",
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
                    navigateToRegisterScreen();
                  },
                  child: Text("Sign Up",
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

  void validateCredentialsThenLoginUser(context) async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final String email;
      final String password;

      email = _emailController.text;
      password = _passwordController.text;

      widget.loginFunction(email, password);
    }
  }

  navigateToRegisterScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const RegisterPage();
    }));
  }

  navigateToHomePage() {
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //   return const HomePage();
    // }));
  }
}
