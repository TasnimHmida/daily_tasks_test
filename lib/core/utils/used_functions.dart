import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/authentication/data/models/user_model.dart';

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
          child: Image.asset(
            '${users[i].profilePicture}',
            width: 20.w,
            height: 20.w,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  return images;
}