import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/manage_user/data/models/user_model.dart';
import '../app_theme.dart';

void showSnackBar(
    BuildContext context, String message, Color snackBarBackgroundColor,
    {int height = 0, void Function()? onSnackBarCompleted}) async {
  final snackBar = SnackBar(
    backgroundColor: snackBarBackgroundColor,
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    dismissDirection: DismissDirection.up,
    margin: EdgeInsets.only(bottom: 50.h + height, right: 20, left: 20),
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context)
      .showSnackBar(snackBar)
      .closed
      .whenComplete(onSnackBarCompleted ?? () {});
}

List<Widget> buildImages(List<UserModel> users) {
  List<Widget> images = [];

  for (int i = 0; i < users.length; i++) {
    images.add(
      Positioned(
        left: 15.w * i,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80.0),
          child:

          users[i].profilePicture != null
              ? CircleAvatar(
              radius: 10.r,
              backgroundImage: NetworkImage(
                users[i].profilePicture!,
              ))
              : CircleAvatar(
            radius: 10.r,
            backgroundImage: const AssetImage(
              'assets/images/profile_image.png',
            ),
          ),
        ),
      ),
    );
  }

  return images;
}

Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    lastDate: DateTime(3000),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    firstDate: DateTime.now(),
    // Change this line
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: fiord,
            onPrimary: Colors.white,
            onSurface: goldenRod,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: goldenRod,
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  return pickedDate;
}

Future<TimeOfDay?> selectTime(BuildContext context) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime:
        TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: fiord,
            onPrimary: Colors.white,
            onSurface: goldenRod,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: goldenRod,
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  return pickedTime;
}
