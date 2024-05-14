import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_theme.dart';
import '../../data/models/task_model.dart';

class TaskLine extends StatefulWidget {
  final TaskModel task;
  final Function(TaskModel) updateTaskFunc;

  const TaskLine({Key? key, required this.task, required this.updateTaskFunc})
      : super(key: key);

  @override
  _TaskLineState createState() => _TaskLineState();
}

class _TaskLineState extends State<TaskLine> {
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isDone = widget.task.isDone ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDone = !isDone;
        });
        widget.updateTaskFunc(TaskModel(
            name: widget.task.name,
            isDone: isDone,
            projectId: widget.task.projectId,
            userId: widget.task.userId,
            id: widget.task.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        color: fiord,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.task.name ?? '',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 7.h),
                color: goldenRod,
                child: SvgPicture.asset(
                    'assets/icons/task_${isDone ? '' : 'not_'}done_icon.svg')),
          ],
        ),
      ),
    );
  }
}
