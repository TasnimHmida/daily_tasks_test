import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../data/models/project_model.dart';

class OngoingTaskCard extends StatefulWidget {
  final ProjectModel project;

  const OngoingTaskCard({super.key, required this.project});

  @override
  _OngoingTaskCardState createState() => _OngoingTaskCardState();
}

class _OngoingTaskCardState extends State<OngoingTaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      color: fiord,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.project.name ?? '',
            style: TextStyle(
                fontFamily: 'PilatExtended',
                fontSize: 21.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.2),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Team members",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        SizedBox(
                          height: 20.h,
                          width: 65.w,
                          child: Stack(
                              children: buildImages([
                            const UserModel(
                                profilePicture: 'assets/images/user_image.png'),
                            const UserModel(
                                profilePicture: 'assets/images/user_image.png'),
                            const UserModel(
                                profilePicture: 'assets/images/user_image.png'),
                            const UserModel(
                                profilePicture: 'assets/images/user_image.png'),
                          ])),
                        ),
                      ]),
                  SizedBox(height: 10.h),
                  Text(
                    "Due on : 21 March",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              CircularPercentIndicator(
                  radius: 30.r,
                  lineWidth: 3.w,
                  percent: .6,
                  center: Text(
                    "60%",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  progressColor: goldenRod,
                  backgroundColor: pickledBlueWood,
                  reverse: true,
                  animation: true)
            ],
          ),
        ],
      ),
    );
  }
}
