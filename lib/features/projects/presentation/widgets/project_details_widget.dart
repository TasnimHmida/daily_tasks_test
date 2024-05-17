import 'package:daily_tasks_test/features/projects/presentation/widgets/search_box.dart';
import 'package:daily_tasks_test/features/projects/presentation/widgets/task_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../../data/models/project_model.dart';
import '../../data/models/task_model.dart';
import '../pages/add_or_edit_project_page.dart';
import 'add_task_popup.dart';
import 'completed_task_card.dart';
import 'ongoing_task_card.dart';

class ProjectDetailsWidget extends StatefulWidget {
  final ProjectModel project;
  final List<TaskModel> tasks;
  final Function() refreshFunc;
  final Function(TaskModel, double) addTaskFunc;
  final Function(TaskModel, double) updateTaskFunc;

  const ProjectDetailsWidget({
    super.key,
    required this.project,
    required this.tasks,
    required this.refreshFunc,
    required this.addTaskFunc,
    required this.updateTaskFunc,
  });

  @override
  _ProjectDetailsWidgetState createState() => _ProjectDetailsWidgetState();
}

class _ProjectDetailsWidgetState extends State<ProjectDetailsWidget> {
  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String selectedDateApi = DateFormat('yyyy/MM/dd').format(DateTime.now());
  String selectedTime = DateFormat('hh:mm a').format(DateTime.now());
  late double projectProgress;
  List<TaskModel> tasks = [];

  String formattedDate = '';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    setState(() {
      projectProgress = widget.project.percentage ?? 0;
      tasks = widget.tasks;
    });
    DateTime date = DateTime.parse(widget.project.date ?? '');
    int day = date.day;
    String month = DateFormat('MMMM').format(date);
    formattedDate = '$day $month';
  }

  void _calculateProjectProgress() {
    if (tasks.isNotEmpty) {
      int completedTasks = tasks.where((task) => task.isDone ?? false).length;
      setState(() {
        projectProgress = completedTasks * 100 / tasks.length;
      });
    } else {
      setState(() {
        projectProgress = 0.0;
      });
    }
  }

  void _updateProjectProgress() {
    setState(() {
      _calculateProjectProgress();
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
            buttonFunction: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddTaskPopup(
                    addTaskFunc: (TaskModel task) {
                      tasks.add(task);
                      _updateProjectProgress();
                      widget.addTaskFunc(task, projectProgress);
                      Navigator.of(context).pop();
                    },
                    projectId: widget.project.id ?? 0,
                  ); // Show the popup dialog
                },
              );
            },
            text: "Add Task",
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: homePagePadding,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .8,
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
                      "Project Details",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final information = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddOrEditProjectPage(
                                    project: widget.project,
                                    returnNavBarFunc: () {},
                                  )),
                        );
                        if (information != null) {
                          widget.refreshFunc();
                        }
                      },
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
                                child: Stack(children: buildImages(widget.project.members ?? [])),
                              ),
                            ])
                      ]),
                      SizedBox(width: 10.w),
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
                          percent: projectProgress / 100,
                          center: Text(
                            '${projectProgress.toInt().toString()}%',
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
                  child: tasks.isEmpty
                      ? Center(
                          child: Text(
                          'No tasks to this project yet.',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ))
                      : ListView.separated(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      index == tasks.length - 1 ? 200.h : 0),
                              child: TaskLine(
                                  task: tasks[index],
                                  updateTaskFunc: (TaskModel task) {
                                    setState(() {
                                      tasks[index] = task;
                                    });
                                    _updateProjectProgress();
                                    widget.updateTaskFunc(
                                        task, projectProgress);
                                  }),
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
      )),
    );
  }
}
