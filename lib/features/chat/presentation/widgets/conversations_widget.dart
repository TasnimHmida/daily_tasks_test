import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timeago/timeago.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../../data/models/conversation_model.dart';
import '../pages/create_new_conversation_page.dart';
import '../pages/messages_page.dart';

class ConversationsWidget extends StatefulWidget {
  final List<ConversationModel> conversations;
  final Function() goBackToHomeScreenFunc;
  final Function() refreshFunc;

  const ConversationsWidget({
    super.key,
    required this.conversations,
    required this.goBackToHomeScreenFunc,
    required this.refreshFunc,
  });

  @override
  _ConversationsWidgetState createState() => _ConversationsWidgetState();
}

class _ConversationsWidgetState extends State<ConversationsWidget> {
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
                "Messages",
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
          MainButton(
            buttonFunction: () async {
              final information = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CreateNewConversationPage(conversations: widget.conversations)),
              );
              if (information != null) {
                widget.refreshFunc();
              }
            },
            text: "Chat",
          ),
          Expanded(
            child: widget.conversations.isEmpty
                ? Center(
                    child: Text(
                      'No conversations yet',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: widget.conversations.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          final information = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MessagesPage(
                                        conversationId:
                                        widget.conversations[index].id.toString(),
                                        contact: widget.conversations[index].contact ??
                                            const UserModel())),
                          );
                          if (information != null) {
                            widget.refreshFunc();
                          }
                        },
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
                                  widget.conversations[index].contact
                                              ?.profilePicture !=
                                          null
                                      ? CircleAvatar(
                                          radius: 25.r,
                                          backgroundImage: NetworkImage(
                                            widget.conversations[index].contact!
                                                .profilePicture!,
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
                                        widget.conversations[index].contact
                                                ?.userName ??
                                            '',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        widget.conversations[index]
                                                .lastMessage ??
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
                                      widget.conversations[index]
                                              .lastMessageDate ??
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
