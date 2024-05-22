import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/app_theme.dart';

class MessageBar extends StatefulWidget {
  final Function(String) sendMessageFunc;

  const MessageBar({
    super.key,
    required this.sendMessageFunc,
  });

  @override
  State<MessageBar> createState() => MessageBarState();
}

class MessageBarState extends State<MessageBar> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      color: outerSpace,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 50.w),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: _textController,
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type a message',
                hintStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: nepal),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              widget.sendMessageFunc(_textController.text);
              setState((){
                _textController.text='';
              });
            },
            icon: SvgPicture.asset(
              'assets/icons/send_icon.svg',
              height: 24.h,
            ),
          ),
        ],
      ),
    );
  }
}