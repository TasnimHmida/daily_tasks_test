import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timeago/timeago.dart';
import '../../../../core/app_theme.dart';
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
    final categorizedNotifications =
    categorizeNotifications(widget.notifications);

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
                SizedBox(width: 20.w),
              ],
            ),
            SizedBox(height: 20.h),
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
                  : ListView.builder(
                itemCount: categorizedNotifications.length,
                itemBuilder: (context, index) {
                  final category = categorizedNotifications[index];
                  final notifications = category['notifications']
                  as List<NotificationModel>;

                  if (notifications.isEmpty) {
                    return Container();
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          category['category'],
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        ListView.separated(
                          shrinkWrap: true,
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: notifications.length,
                          itemBuilder: (context, notifIndex) {
                            final notification = notifications[notifIndex];
                            final parsedContent = parseNotificationContent(
                                notification.content ?? '');

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    notification.userModel
                                        ?.profilePicture !=
                                        null
                                        ? CircleAvatar(
                                      radius: 25.r,
                                      backgroundImage: NetworkImage(
                                        notification.userModel!
                                            .profilePicture!,
                                      ),
                                    )
                                        : CircleAvatar(
                                      radius: 25.r,
                                      backgroundImage:
                                      const AssetImage(
                                        'assets/images/profile_image.png',
                                      ),
                                    ),
                                    SizedBox(width: 15.w),
                                    SizedBox(
                                      width: 250.w,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: parsedContent.username,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                              ' ${parsedContent.action}',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                color: silver,
                                              ),
                                            ),
                                            if (parsedContent.projectName !=
                                                null)
                                              TextSpan(
                                                text:
                                                ' ${parsedContent.projectName}',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontFamily: 'Inter',
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color: goldenRod,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.h, right: 10.w),
                                  child: Text(
                                    format(
                                        notification.createdAt ??
                                            DateTime.now(),
                                        locale: 'en_short'),
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, notifIndex) =>
                              SizedBox(height: 25.h),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ParsedNotificationContent parseNotificationContent(String content) {
    final RegExp projectRegExp =
    RegExp(r'^(.*?) added you to a new project (.*?)$');
    final RegExp messageRegExp = RegExp(r'^(.*?) sent you a new message$');

    if (projectRegExp.hasMatch(content)) {
      final match = projectRegExp.firstMatch(content);
      if (match != null) {
        return ParsedNotificationContent(
          match.group(1)!,
          'added you to a new project',
          match.group(2),
        );
      }
    } else if (messageRegExp.hasMatch(content)) {
      final match = messageRegExp.firstMatch(content);
      if (match != null) {
        return ParsedNotificationContent(
          match.group(1)!,
          'sent you a new message',
        );
      }
    }

    throw Exception('Unknown notification format');
  }

  List<Map<String, dynamic>> categorizeNotifications(
      List<NotificationModel> notifications) {
    final now = DateTime.now();
    final newNotifications = <NotificationModel>[];
    final earlierNotifications = <NotificationModel>[];

    for (var notification in notifications) {
      if (notification.createdAt != null) {
        final difference = now.difference(notification.createdAt!);
        if (difference.inHours < 24) {
          newNotifications.add(notification);
        } else {
          earlierNotifications.add(notification);
        }
      }
    }

    return [
      {'category': 'New', 'notifications': newNotifications},
      {'category': 'Earlier', 'notifications': earlierNotifications},
    ];
  }
}

class ParsedNotificationContent {
  final String username;
  final String action;
  final String? projectName;

  ParsedNotificationContent(this.username, this.action, [this.projectName]);
}
