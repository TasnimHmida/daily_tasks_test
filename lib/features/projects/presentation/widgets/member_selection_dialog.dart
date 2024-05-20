import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme.dart';
import '../../../manage_user/data/models/user_model.dart';

class MemberSelectionDialog extends StatefulWidget {
  final List<UserModel> users;
  final Function(List<UserModel>) onSelected;

  const MemberSelectionDialog(
      {required this.users, required this.onSelected, Key? key})
      : super(key: key);

  @override
  _MemberSelectionDialogState createState() => _MemberSelectionDialogState();
}

class _MemberSelectionDialogState extends State<MemberSelectionDialog> {
  List<UserModel> selectedMembers = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: outerSpace,
      title: Text(
        'Select Team Members',
        style: TextStyle(
            fontFamily: 'PilatExtended',
            fontSize: 21.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.2),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: widget.users.map((user) {
            return CheckboxListTile(
                secondary: user.profilePicture != null
                    ? CircleAvatar(
                        radius: 20.r,
                        backgroundImage: NetworkImage(
                          user.profilePicture!,
                        ))
                    : CircleAvatar(
                        radius: 20.r,
                        backgroundImage: const AssetImage(
                          'assets/images/profile_image.png',
                        ),
                      ),
                title: Text(user.userName ?? '',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    )),
                value: selectedMembers.contains(user),
                onChanged: (bool? selected) {
                  setState(() {
                    if (selected == true) {
                      selectedMembers.add(user);
                    } else {
                      selectedMembers.remove(user);
                    }
                  });
                },
                activeColor: goldenRod,
                checkColor: outerSpace);
          }).toList(),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onSelected(selectedMembers);
            Navigator.of(context).pop();
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
