import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme.dart';

class HorizontalCalendarWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const HorizontalCalendarWidget({super.key, required this.onDateSelected});

  @override
  _HorizontalCalendarWidgetState createState() =>
      _HorizontalCalendarWidgetState();
}

class _HorizontalCalendarWidgetState extends State<HorizontalCalendarWidget> {
  DateTime selectedDate = DateTime.now();
  int currentDateSelectedIndex = 2; // Index 2 will be the third item
  final ScrollController scrollController = ScrollController();

  List<String> listOfMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<String> listOfDays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ]; // List of Days

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          listOfMonths[selectedDate.month - 1],
          style: TextStyle(
              fontSize: 20.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 80.h,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 15.w);
            },
            itemCount: 365,
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              DateTime date = DateTime.now().subtract(Duration(days: 2 - index));
              return InkWell(
                onTap: () {
                  setState(() {
                    currentDateSelectedIndex = index;
                    selectedDate = date;
                  });
                  widget.onDateSelected(date);
                },
                child: Container(
                  width: 50.w,
                  alignment: Alignment.center,
                  color: currentDateSelectedIndex == index
                      ? goldenRod
                      : outerSpace,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: currentDateSelectedIndex == index
                                ? ebonyClay
                                : Colors.white),
                      ),
                      Text(
                        listOfDays[date.weekday - 1].toString(),
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: currentDateSelectedIndex == index
                                ? ebonyClay
                                : Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
