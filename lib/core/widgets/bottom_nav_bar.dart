import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../features/projects/presentation/pages/home_page.dart';
import '../app_theme.dart';

class BottomNavBar extends StatefulWidget {
  final int? specificIndex;

  const BottomNavBar({
    Key? key,
    this.specificIndex,
  }) : super(key: key);

  @override
  _BottomNavBar createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.specificIndex ?? 0;

    // BlocProvider.of<CoreBloc>(context).add(GetRemoteUserEvent());
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _onRefresh(BuildContext context) async {
    // BlocProvider.of<CoreBloc>(context).add(GetRemoteUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const HomePage(),
      const Center(child: Text('chat screen')),
      const Center(child: Text('add project screen')),
      const Center(child: Text('calendar screen')),
      const Center(child: Text('notifications screen'))
    ];
    return
        // BlocConsumer<CoreBloc, CoreState>(
        // listener: (context, state) {},
        // builder: (context, state) {
        //   return
        GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
                key: scaffoldKey,
                body:
                    // (!state.isLoading &&
                    //     state.error == OFFLINE_FAILURE_MESSAGE)
                    //     ? RefreshIndicator(
                    //     child: ListView(
                    //       children: [
                    //         SizedBox(
                    //           height: 200.h,
                    //         ),
                    //         Center(
                    //           child: NoDataFoundWidget(
                    //             message: "No Internet connection".tr(context),
                    //             image: "assets/images/no_internet.svg",
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //     onRefresh: () => _onRefresh(context))
                    //     :
                    IndexedStack(
                  index: _currentIndex,
                  children: widgetOptions,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: outerSpace,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: goldenRod,
                  unselectedItemColor: lynch,
                  selectedFontSize: 10.sp,
                  unselectedFontSize: 10.sp,
                  currentIndex: _currentIndex,
                  onTap: (int newIndex) => _onItemTapped(newIndex),
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/icons/home_icon.svg",
                          color: _currentIndex == 0 ? goldenRod : lynch,
                          fit: BoxFit.fill),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/icons/chat_icon.svg",
                          color: _currentIndex == 1 ? goldenRod : lynch,
                          fit: BoxFit.fill),
                      label: "Chat",
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        height: 54.w,
                        width: 54.w,
                        color: goldenRod,
                        child: SizedBox(
                          height: 20.w,
                          width: 20.w,
                          child: SvgPicture.asset(
                              "assets/icons/add_task_icon.svg",
                              height: 20.w),
                        ),
                      ),
                      label: "",
                    ),
                    //state show just for the club user
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/icons/calendar_icon.svg",
                          color: _currentIndex == 3 ? goldenRod : lynch,
                          fit: BoxFit.fill),
                      label: "Calendar",
                    ),

                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                          "assets/icons/notifications_icon.svg",
                          color: _currentIndex == 4 ? goldenRod : lynch,
                          fit: BoxFit.fill),
                      label: "Notification",
                    ),
                  ],
                ))
            //   );
            // },
            );
  }
}
