import 'package:daily_tasks_test/features/projects/presentation/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/input_validation.dart';
import '../../../../core/utils/used_functions.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../data/models/project_model.dart';
import 'completed_task_card.dart';
import 'ongoing_task_card.dart';

class AddOrEditProjectWidget extends StatefulWidget {
  final Function() returnNavBarFunc;
  final Function(ProjectModel) addOrEditProjectFunction;
  final bool isLoading;
  final ProjectModel? project;

  const AddOrEditProjectWidget({
    super.key,
    required this.returnNavBarFunc,
    required this.isLoading,
    required this.addOrEditProjectFunction,
    this.project,
  });

  @override
  _AddOrEditProjectWidgetState createState() => _AddOrEditProjectWidgetState();
}

class _AddOrEditProjectWidgetState extends State<AddOrEditProjectWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String selectedDateApi = DateFormat('yyyy/MM/dd').format(DateTime.now());
  String selectedTime = DateFormat('hh:mm a').format(DateTime.now());
  List<UserModel> members = [
    const UserModel(
        userName: 'Robert', profilePicture: 'assets/images/user_image.png'),
    const UserModel(
        userName: 'Sophia', profilePicture: 'assets/images/user_image.png'),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      setState(() {
        _titleController.text = widget.project!.name ?? '';
        _detailsController.text = widget.project!.details ?? '';
        selectedDate = widget.project!.date ?? '';
        selectedDateApi = widget.project!.date ?? '';
        selectedTime = widget.project!.time ?? '';
      });
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
          child: Form(
            key: _formKey,
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
                        widget.returnNavBarFunc();
                      },
                      child: SvgPicture.asset(
                        'assets/icons/arrow_back.svg',
                        height: 20.h,
                      ),
                    ),
                    Text(
                      "${widget.project != null ? "Update" : "Create"} New Project",
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
                      controller: _titleController,
                      hintText: 'Project Title',
                      validator: (value) =>
                          validateEmptyField(value!, 'Project Title', context))
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
                      maxLines: 3,
                      validator: (value) => validateEmptyField(
                          value!, 'Project Details', context))
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
                      members.isEmpty
                          ? Text(
                              'no members yet.',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            )
                          : SizedBox(
                              height: 40.h,
                              width: 300.w,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: members.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      color: fiord,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            Image.asset(
                                              '${members[index].profilePicture}',
                                              width: 20.w,
                                              height: 20.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              members[index].userName ?? '',
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            )
                                          ]),
                                          SizedBox(
                                            width: 30.w,
                                          ),
                                          SvgPicture.asset(
                                            'assets/icons/close_icon.svg',
                                            height: 20.h,
                                          ),
                                        ],
                                      ));
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(width: 10.w);
                                },
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
                              selectedDateApi =
                                  DateFormat('yyyy/MM/dd').format(date);
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
                      buttonFunction: () {
                        final isValid = _formKey.currentState!.validate();
                        if (isValid) {
                          widget.addOrEditProjectFunction(ProjectModel(
                            name: _titleController.text,
                            details: _detailsController.text,
                            time: selectedTime,
                            date: selectedDateApi,
                          ));
                        }
                      },
                      text: widget.project != null ? "Update" : "Create",
                      isLoading: widget.isLoading),
                ]),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
