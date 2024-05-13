import 'package:daily_tasks_test/features/projects/presentation/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../data/models/project_model.dart';
import '../../data/models/task_model.dart';
import 'completed_task_card.dart';
import 'ongoing_task_card.dart';

class ProjectDetailsWidget extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailsWidget({
    super.key,
    required this.project,
  });

  @override
  _ProjectDetailsWidgetState createState() => _ProjectDetailsWidgetState();
}

class _ProjectDetailsWidgetState extends State<ProjectDetailsWidget> {
  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String selectedDateApi = DateFormat('yyyy/MM/dd').format(DateTime.now());
  String selectedTime = DateFormat('hh:mm a').format(DateTime.now());
  List<UserModel> members = [
    const UserModel(
        userName: 'Robert', profilePicture: 'assets/images/user_image.png'),
    const UserModel(
        userName: 'Sophia', profilePicture: 'assets/images/user_image.png'),
  ];

  List<TaskModel> tasks = [
    const TaskModel(
      name: 'User Interviews',
      isDone: true,
    ),
    const TaskModel(
      name: 'Wireframes',
      isDone: true,
    ),
    const TaskModel(
      name: 'Design System',
      isDone: true,
    ),
    const TaskModel(
      name: 'Design System',
      isDone: false,
    ),
    const TaskModel(
      name: 'Final Mockups',
      isDone: false,
    ),
  ];

  String formattedDate = '';

  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.parse(widget.project.date ?? '');
    int day = date.day;
    String month = DateFormat('MMMM').format(date);
    setState(() {
      formattedDate = '$day $month';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ebonyClay,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 25.h),
        color: outerSpace,
        width: double.infinity,
        height: 114.h,
        child: SizedBox(
          width: 318.w,
          child: MainButton(
            buttonFunction: () {},
            text: "Add Task",
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: homePagePadding,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .99,
            child: Expanded(
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
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          'assets/icons/arrow_back.svg',
                          height: 20.h,
                        ),
                      ),
                      Text(
                        "Project Details",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/icons/edit_icon.svg',
                          height: 24.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    widget.project.name ?? '',
                    style: TextStyle(
                        fontFamily: 'PilatExtended',
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.2),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.h, vertical: 10.h),
                              color: goldenRod,
                              child: SvgPicture.asset(
                                  'assets/icons/due_date_icon.svg')),
                          SizedBox(width: 10.w),
                          Column(children: [
                            Text(
                              'Due Date',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: nepal,
                              ),
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ])
                        ]),
                        Row(children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.h, vertical: 10.h),
                              color: goldenRod,
                              child: SvgPicture.asset(
                                  'assets/icons/project_team_icon.svg')),
                          SizedBox(width: 10.w),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Project Team',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: nepal,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                SizedBox(
                                  height: 25.h,
                                  width: 80.w,
                                  child: Stack(children: buildImages(members)),
                                ),
                              ])
                        ]),
                        SizedBox(width: 10.w),
                      ]),
                  SizedBox(height: 30.h),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        Text(
                          widget.project.details ?? '',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: jungleMist,
                          ),
                        ),
                      ]),
                  SizedBox(height: 30.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Project Progress",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        CircularPercentIndicator(
                            radius: 30.r,
                            lineWidth: 2.4.w,
                            percent:
                                (widget.project.percentage ?? 0).toInt() / 100,
                            center: Text(
                              '${(widget.project.percentage ?? 0).toInt().toString()}%',
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
                            animation: true,
                            animationDuration: 800)
                      ]),
                  SizedBox(height: 30.h),
                  Text(
                    "All Tasks",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: index == tasks.length - 1 ? 200.h : 0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 7.h),
                            color: fiord,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tasks[index].name ?? '',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7.h, vertical: 7.h),
                                    color: goldenRod,
                                    child: SvgPicture.asset(
                                        'assets/icons/task_${tasks[index].isDone! ? '' : 'not_'}done_icon.svg')),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 15.h);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
