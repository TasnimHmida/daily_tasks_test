import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/widgets/main_button.dart';
import '../../data/models/conversation_model.dart';

class ConversationsWidget extends StatefulWidget {
  final List<ConversationModel> conversations;

  const ConversationsWidget({
    super.key,
    required this.conversations,
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
                  Navigator.of(context).pop();
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
            buttonFunction: () {},
            text: "Chat",
            // isLoading: widget.isLoading
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
                      return GestureDetector(
                        onTap: () async {
                          // final information = await Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => ProjectDetailsPage(
                          //           project: widget.conversations[index])),
                          // );
                          // if (information != null) {
                          //   widget.refreshFunc();
                          // }
                        },
                        child: Container(
                          height: 80.h,
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  widget.conversations[index].userTwo
                                              ?.profilePicture !=
                                          null
                                      ? CircleAvatar(
                                          radius: 25.r,
                                          backgroundImage: NetworkImage(
                                            widget.conversations[index].userTwo!
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
                                        widget.conversations[index].userTwo
                                                ?.userName ??
                                            '',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        widget.conversations[index].createdAt
                                            .toString(),
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
