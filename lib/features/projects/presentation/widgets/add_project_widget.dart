import 'package:daily_tasks_test/features/projects/presentation/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../data/models/project_model.dart';
import 'completed_task_card.dart';
import 'ongoing_task_card.dart';

class AddProjectWidget extends StatefulWidget {
  final Function() returnNavBarFunc;

  const AddProjectWidget({
    super.key,
    required this.returnNavBarFunc,
  });

  @override
  _AddProjectWidgetState createState() => _AddProjectWidgetState();
}

class _AddProjectWidgetState extends State<AddProjectWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String selectedTime = DateFormat('hh:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ebonyClay,
      body: SafeArea(
          child: Padding(
        padding: homePagePadding,
        child: SingleChildScrollView(
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
                      widget.returnNavBarFunc();
                    },
                    child: SvgPicture.asset(
                      'assets/icons/arrow_back.svg',
                      height: 20.h,
                    ),
                  ),
                  Text(
                    "Create New Project",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 50.w)
                ],
              ),
              SizedBox(height: 30.h),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Project Title",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15.h),
                InputField(
                    controller: _titleController, hintText: 'Project Title')
              ]),
              SizedBox(height: 30.h),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Project Details",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15.h),
                InputField(
                    controller: _detailsController,
                    hintText: 'Project Details',
                    maxLines: 3)
              ]),
              SizedBox(height: 30.h),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Add team members",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'no members yet.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.h, vertical: 7.h),
                          color: goldenRod,
                          child: SvgPicture.asset(
                              'assets/icons/add_task_icon.svg')),
                    ),
                  ],
                )
              ]),
              SizedBox(height: 30.h),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Time & Date",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var time = await selectTime(context) ??
                              const TimeOfDay(hour: 10, minute: 30);
                          String formattedTime = time.format(context);
                          List<String> splitTime = formattedTime.split(' ');
                          setState(() {
                            selectedTime = '${splitTime[0]} ${splitTime[1]}';
                          });
                        },
                        child: Row(children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7.h, vertical: 7.h),
                              color: goldenRod,
                              child: SvgPicture.asset(
                                  'assets/icons/clock_icon.svg')),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 7.h),
                            color: fiord,
                            child: Text(
                              selectedTime,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var date =
                              await selectDate(context) ?? DateTime.now();
                          setState(() {
                            selectedDate =
                                DateFormat('dd/MM/yyyy').format(date);
                          });
                        },
                        child: Row(children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7.h, vertical: 7.h),
                              color: goldenRod,
                              child: SvgPicture.asset(
                                  'assets/icons/calendar_icon.svg',
                                  color: outerSpace)),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 7.h),
                            color: fiord,
                            child: Text(
                              selectedDate,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ]),
                SizedBox(height: 150.h),
                MainButton(
                  buttonFunction: () {},
                  text: "Create",
                ),
              ]),
            ],
          ),
        ),
      )),
    );
  }
}
