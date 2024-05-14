import 'dart:io';

import 'package:daily_tasks_test/features/projects/presentation/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/input_validation.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../data/models/project_model.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  File? imageFile;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: homePagePadding,
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop('refresh');
                    },
                    child: SvgPicture.asset(
                      'assets/icons/arrow_back.svg',
                      height: 20.h,
                    ),
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20.w)
                ],
              ),
              Column(children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: goldenRod, width: 2)),
                      child: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: imageFile != null
                            ? CircleAvatar(
                                radius: 60.r,
                                backgroundImage: Image.file(imageFile!).image)
                            : ClipOval(
                                child: Image.asset(
                                    'assets/images/profile_image.png',
                                    height: 127.h)),
                      ),
                    ),
                    Positioned(
                        bottom: 5.h,
                        right: 3.w,
                        child: GestureDetector(
                          onTap: () {
                            _pickImageFromGallery();
                          },
                          child: Container(
                            padding: EdgeInsets.all(7.w),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ebonyClay,
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/add_task_icon.svg',
                              color: Colors.white,
                              height: 20.h,
                            ),
                          ),
                        ))
                  ],
                ),
                SizedBox(height: 50.h),
                InputField(
                    controller: _nameController,
                    hintText: 'Username',
                    prefixIcon: 'assets/icons/profile_user_icon.svg',
                    isEdit: true,
                    validator: (value) =>
                        validateField(value!, 'Username', context)),
                SizedBox(height: 20.h),
                InputField(
                    controller: _emailController,
                    hintText: 'Email@gmail.com',
                    prefixIcon: 'assets/icons/profile_email_icon.svg',
                    isEdit: true,
                    validator: (value) => validateEmail(value!, context)),
                SizedBox(height: 20.h),
                InputField(
                    controller: _passwordController,
                    hintText: 'Password',
                    prefixIcon: 'assets/icons/profile_password_icon.svg',
                    isEdit: true,
                    validator: (value) => validatePassword(value!, context)),
              ]),
              SizedBox(height: 200.h),
              MainButton(
                buttonFunction: () {},
                text: "Logout",
                // isLoading: widget.isLoading
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      setState(() {
        imageFile = File(pickedFile.path);
        print("imageFileimageFile $imageFile");
      });
    } catch (errorMsg) {
      print("image error msg ${errorMsg.toString()}");
    }
  }
}
