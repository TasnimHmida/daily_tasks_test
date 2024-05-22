import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timeago/timeago.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../../data/models/notification_model.dart';

class NotificationsWidget extends StatefulWidget {
  final List<NotificationModel> notifications;
  final Function() goBackToHomeScreenFunc;

  const NotificationsWidget({
    super.key,
    required this.notifications,
    required this.goBackToHomeScreenFunc,
  });

  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
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
                  widget.goBackToHomeScreenFunc();
                },
                child: SvgPicture.asset(
                  'assets/icons/arrow_back.svg',
                  height: 24.h,
                ),
              ),
              Text(
                "Notifications",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20.w)
            ],
          ),
          SizedBox(height: 40.h),
          Expanded(
            child: widget.notifications.isEmpty
                ? Center(
                    child: Text(
                      'No notifications yet',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: widget.notifications.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {},
                        child: Container(
                          height: 80.h,
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  widget.notifications[index].userModel
                                              ?.profilePicture !=
                                          null
                                      ? CircleAvatar(
                                          radius: 25.r,
                                          backgroundImage: NetworkImage(
                                            widget.notifications[index]
                                                .userModel!.profilePicture!,
                                          ))
                                      : CircleAvatar(
                                          radius: 25.r,
                                          backgroundImage: const AssetImage(
                                            'assets/images/profile_image.png',
                                          ),
                                        ),
                                  SizedBox(width: 20.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.notifications[index].userModel
                                                ?.userName ??
                                            '',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        widget.notifications[index].content ??
                                            '',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 20.h, right: 10.w),
                                child: Text(
                                  format(
                                      widget.notifications[index].createdAt ??
                                          DateTime.now(),
                                      locale: 'en_short'),
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 10.w);
                    },
                  ),
          )
        ],
      ),
    ));
  }
}
