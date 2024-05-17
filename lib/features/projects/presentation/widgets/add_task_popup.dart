import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/utils/input_validation.dart';
import '../../../../core/widgets/input_field.dart';
import '../../data/models/task_model.dart';

class AddTaskPopup extends StatefulWidget {
  final int projectId;
  final Function(TaskModel) addTaskFunc;

  const AddTaskPopup({Key? key, required this.addTaskFunc, required this.projectId}) : super(key: key);

  @override
  _AddTaskPopupState createState() => _AddTaskPopupState();
}

class _AddTaskPopupState extends State<AddTaskPopup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  bool isTaskDone = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: outerSpace,
      title: Text(
        'Task Details',
        style: TextStyle(
            fontFamily: 'PilatExtended',
            fontSize: 21.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.2),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.h),
          Form(
            key: _formKey,
            child: InputField(
                controller: _nameController,
                hintText: 'Task Name',
                validator: (value) =>
                    validateEmptyField(value!, 'Task Name', context)),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Task Status",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                // SizedBox(width: 10.w),
                Switch(
                    value: isTaskDone,
                    onChanged: (value) {
                      setState(() {
                        isTaskDone = value;
                      });
                    },
                    activeColor: goldenRod,
                    inactiveTrackColor: fiord),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog on cancel
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 50.w),
        ElevatedButton(
          onPressed: () {
            final isValid = _formKey.currentState!.validate();
            if (isValid) {
              widget.addTaskFunc(TaskModel(
                name: _nameController.text,
                isDone: isTaskDone,
                projectId: widget.projectId
              ));
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(goldenRod),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
          ),
          child: Text(
            'Confirm',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
