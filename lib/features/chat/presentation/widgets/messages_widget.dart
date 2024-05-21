import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/app_theme.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../../data/models/message_model.dart';
import 'chat_bubble.dart';
import 'message_bar.dart';

class MessagesWidget extends StatefulWidget {
  final List<MessageModel> messages;
  final UserModel contact;
  final Function(String) sendMessageFunc;

  const MessagesWidget({
    super.key,
    required this.messages,
    required this.contact,
    required this.sendMessageFunc,
  });

  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: homePagePadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop('refresh');
                      },
                      child: SvgPicture.asset(
                        'assets/icons/arrow_back.svg',
                        height: 24.h,
                      ),
                    ),
                    SizedBox(width: 50.w),
                    Row(
                      children: [
                        widget.contact.profilePicture != null
                            ? CircleAvatar(
                                radius: 20.r,
                                backgroundImage: NetworkImage(
                                  widget.contact.profilePicture!,
                                ))
                            : CircleAvatar(
                                radius: 20.r,
                                backgroundImage: const AssetImage(
                                  'assets/images/profile_image.png',
                                ),
                              ),
                        SizedBox(width: 15.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.contact.userName ?? '',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Online',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: silver,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 20.w)
              ],
            ),
            Expanded(
              child: widget.messages.isEmpty
                  ? Center(
                      child: Text(
                        'Start your conversation now.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: silver,
                        ),
                      ),
                    )
                  : ListView.builder(
                      reverse: true,
                      itemCount: widget.messages.length,
                      itemBuilder: (context, index) {
                        final message = widget.messages[index];
                        return ChatBubble(
                          message: message,
                        );
                      },
                    ),
            ),
            MessageBar(
              sendMessageFunc: widget.sendMessageFunc,
            ),
          ],
        ),
      ),
    );
  }
}
