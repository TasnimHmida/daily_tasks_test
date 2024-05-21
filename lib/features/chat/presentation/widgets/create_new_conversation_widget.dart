import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../../data/models/conversation_model.dart';

class CreateNewConversationWidget extends StatefulWidget {
  final List<UserModel> users;
  final Function(UserModel) createConversationFunc;

  const CreateNewConversationWidget({
    super.key,
    required this.users,
    required this.createConversationFunc,
  });

  @override
  _CreateNewConversationWidgetState createState() =>
      _CreateNewConversationWidgetState();
}

class _CreateNewConversationWidgetState
    extends State<CreateNewConversationWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: homePagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  'assets/icons/arrow_back.svg',
                  height: 24.h,
                ),
              ),
              Text(
                "New Message",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SvgPicture.asset(
                'assets/icons/search_icon.svg',
                color: Colors.white,
                height: 24.h,
              ),
            ],
          ),
          SizedBox(height: 50.h),
          Expanded(
            child: widget.users.isEmpty
                ? Center(
                    child: Text(
                      'No users yet',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: widget.users.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          widget.createConversationFunc(widget.users[index]);
                        },
                        child: SizedBox(
                          height: 60.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  widget.users[index].profilePicture != null
                                      ? CircleAvatar(
                                          radius: 20.r,
                                          backgroundImage: NetworkImage(
                                            widget.users[index].profilePicture!,
                                          ))
                                      : CircleAvatar(
                                          radius: 20.r,
                                          backgroundImage: const AssetImage(
                                            'assets/images/profile_image.png',
                                          ),
                                        ),
                                  SizedBox(width: 15.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.users[index].userName ?? '',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 5.h);
                    },
                  ),
          )
        ],
      ),
    ));
  }
}
