import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import '../../data/models/project_model.dart';
import '../pages/project_details_page.dart';

class CompletedTaskCard extends StatefulWidget {
  final ProjectModel project;
  final bool isFirstItem;
  final Function() refreshFunc;

  const CompletedTaskCard(
      {super.key,
      required this.project,
      this.isFirstItem = false,
      required this.refreshFunc});

  @override
  _CompletedTaskCardState createState() => _CompletedTaskCardState();
}

class _CompletedTaskCardState extends State<CompletedTaskCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final information = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProjectDetailsPage(project: widget.project)),
        );
        if (information != null) {
          widget.refreshFunc();
        }
      },
      child: Container(
        padding: EdgeInsets.all(10.w),
        width: 183.w,
        // height: 175.h,
        color: widget.isFirstItem ? goldenRod : fiord,
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
                  color: widget.isFirstItem ? Colors.black : Colors.white,
                  height: 1.2),
            ),
            (widget.project.members ?? []).isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text(
                          "Team members",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color:
                                widget.isFirstItem ? ebonyClay : Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                          width: 65.w,
                          child: Stack(
                              children:
                                  buildImages(widget.project.members ?? [])),
                        ),
                      ])
                : Container(),
            Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Completed",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: widget.isFirstItem ? ebonyClay : Colors.white,
                  ),
                ),
                Text(
                  "100%",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: widget.isFirstItem ? ebonyClay : Colors.white,
                  ),
                ),
              ]),
              SizedBox(height: 5.h),
              Container(
                height: 5.h,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.isFirstItem ? Colors.black : Colors.white,
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
