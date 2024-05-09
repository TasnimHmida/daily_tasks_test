import 'package:daily_tasks_test/features/projects/presentation/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_theme.dart';
import '../../data/models/project_model.dart';
import 'completed_task_card.dart';
import 'ongoing_task_card.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
  });

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<ProjectModel> items = List.generate(
      10, (index) => const ProjectModel(name: 'Real Estate Website Design'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ebonyClay,
      body: SafeArea(
          child: Padding(
        padding: pagePadding,
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
                      "Fazil Laghari",
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
            SearchBox(searchController: _searchController),
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
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return CompletedTaskCard(
                        project: items[index], isFirstItem: index == 0);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 10.w);
                  },
                ),
              ),
            ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  height: 400.h,
                  child: ListView.separated(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return OngoingTaskCard(
                          project: items[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 15.h);
                    },
                  ),
                ),
              ]
            )
          ],
        ),
      )),
    );
  }
}
