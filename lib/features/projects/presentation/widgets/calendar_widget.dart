import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import '../../data/models/project_model.dart';
import '../pages/project_details_page.dart';
import 'horizontal_calendar_widget.dart';

class CalendarWidget extends StatefulWidget {
  final List<ProjectModel> projects;
  final Function() goBackToHomeScreenFunc;
  final Function() goToAddProjectScreenFunc;
  final Function() refreshFunc;

  const CalendarWidget({
    super.key,
    required this.projects,
    required this.goBackToHomeScreenFunc,
    required this.goToAddProjectScreenFunc,
    required this.refreshFunc,
  });

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime selectedDate = DateTime.now();
  List<ProjectModel> filteredProjects = [];
  @override
  void initState() {
    super.initState();
    _filterProjectsByDate(selectedDate);
  }

  void _filterProjectsByDate(DateTime date) {
    setState(() {
      filteredProjects = widget.projects
          .where(
              (project) => project.date == date.toIso8601String().split('T')[0])
          .toList();
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      _filterProjectsByDate(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ebonyClay,
      body: SafeArea(
          child: Padding(
        padding: homePagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    widget.goBackToHomeScreenFunc();
                  },
                  child: SvgPicture.asset(
                    'assets/icons/arrow_back.svg',
                    height: 24.h,
                  ),
                ),
                Text(
                  "Schedule",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.goToAddProjectScreenFunc();
                  },
                  child: SvgPicture.asset(
                    'assets/icons/add_task_icon.svg',
                    height: 24.h,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            HorizontalCalendarWidget(
              onDateSelected: _onDateSelected,
            ),
            SizedBox(height: 40.h),
            Text(
                selectedDate.day == DateTime.now().day
                    ? "Today's Projects"
                    : "Projects on ${DateFormat.MMMMEEEEd().format(selectedDate)}",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: filteredProjects.isEmpty
                  ? Center(
                      child: Text(
                      "No projects on this date.",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ))
                  : ListView.separated(
                      itemCount: filteredProjects.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            final information = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProjectDetailsPage(
                                      project: filteredProjects[index])),
                            );
                            if (information != null) {
                              widget.refreshFunc();
                            }
                          },
                          child: Container(
                            height: 80.h,
                            color: index == 0 ? goldenRod : outerSpace,
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      color: goldenRod,
                                      width: 11.w,
                                      height: 80.h,
                                    ),
                                    SizedBox(width: index == 0 ? 10.w : 25.w),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              filteredProjects[index].name ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                  color: index == 0
                                                      ? ebonyClay
                                                      : Colors.white),
                                            ),
                                            Text(
                                              filteredProjects[index].time ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  color: index == 0
                                                      ? ebonyClay
                                                      : Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 60.w,
                                  height: 20.h,
                                  child: Stack(
                                      clipBehavior: Clip.none,
                                      children: buildImages(
                                          filteredProjects[index].members ??
                                              [])),
                                ),
                              ],
                            ),
                          ),
                        );
                        ;
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 10.w);
                      },
                    ),
            )
          ],
        ),
      )),
    );
  }
}
