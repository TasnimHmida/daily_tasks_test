import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_theme.dart';
import '../../data/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    List<Widget> chatContents = [
      Flexible(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 12.w,
          ),
          decoration: BoxDecoration(
            color: message.isMine != null && message.isMine!
                ? goldenRod
                : outerSpace,
          ),
          child: Text(
            message.content ?? '',
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: message.isMine != null && message.isMine!
                    ? ebonyClay
                    : Colors.white),
          ),
        ),
      ),
    ];
    if (message.isMine != null && message.isMine!) {
      chatContents = chatContents.reversed.toList();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 18.h),
      child: Row(
        mainAxisAlignment: message.isMine != null && message.isMine!
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: chatContents,
      ),
    );
  }
}