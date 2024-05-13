import 'package:daily_tasks_test/features/projects/presentation/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_theme.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../data/models/project_model.dart';
import 'completed_task_card.dart';
import 'ongoing_task_card.dart';

class HomeWidget extends StatefulWidget {
  final List<ProjectModel> projects;
  final UserModel user;
  final Function() refreshFunc;

  const HomeWidget({super.key, required this.projects, required this.user,required this.refreshFunc});

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<ProjectModel> completedProjects = [];
  List<ProjectModel> ongoingProjects = [];

  @override
  void initState() {
    super.initState();
    for (var project in widget.projects) {
      if (project.percentage != null && project.percentage! >= 100) {
        completedProjects.add(project);
      } else {
        ongoingProjects.add(project);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ebonyClay,
      body: SafeArea(
          child: Padding(
        padding: homePagePadding,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.79.sp,
                            fontWeight: FontWeight.w500,
                            color: goldenRod,
                          ),
                        ),
                        Text(
                          widget.user.userName ?? '',
                          style: TextStyle(
                            fontFamily: 'PilatExtended',
                            fontSize: 22.29.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Image.asset('assets/images/user_image.png', height: 48.h),
                  ],
                ),
                SizedBox(height: 30.h),
                SearchBox(searchController: _searchController),
                SizedBox(height: 30.h),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Completed Projects",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    height: 175.h,
                    child: completedProjects.isEmpty
                        ? Center(
                            child: Text(
                            "No Completed Projects Yet.",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ))
                        : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: completedProjects.length,
                            itemBuilder: (context, index) {
                              return CompletedTaskCard(
                                  project: completedProjects[index],
                                  isFirstItem: index == 0,
                                  refreshFunc: widget.refreshFunc
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(width: 10.w);
                            },
                          ),
                  ),
                ]),
                SizedBox(height: 25.h),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ongoing Projects",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Expanded(
                          child: ongoingProjects.isEmpty
                              ? Center(
                                  child: Text(
                                  "No Ongoing Projects Yet.",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ))
                              : ListView.separated(
                                  itemCount: ongoingProjects.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: index ==
                                                  ongoingProjects.length - 1
                                              ? 200.h
                                              : 0),
                                      child: OngoingTaskCard(
                                          project: ongoingProjects[index],
                                          refreshFunc: widget.refreshFunc
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(height: 15.h);
                                  },
                                ),
                        ),
                        // SizedBox(height: 30.h),
                      ]),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
