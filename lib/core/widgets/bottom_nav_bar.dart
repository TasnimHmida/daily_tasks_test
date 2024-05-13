import 'package:daily_tasks_test/injection_container.dart' as di;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../features/authentication/data/models/user_model.dart';
import '../../features/projects/presentation/pages/add_or_edit_project_page.dart';
import '../../features/projects/presentation/pages/home_page.dart';
import '../app_theme.dart';
import '../bloc/core_bloc.dart';
import '../strings/failures.dart';

class BottomNavBar extends StatefulWidget {
  final UserModel user;
  final int? specificIndex;

  const BottomNavBar({
    super.key,
    this.specificIndex,
    required this.user,
  });

  @override
  _BottomNavBar createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  bool isShowNavBar = true;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (_currentIndex == 2) {
      setState(() {
        isShowNavBar = false;
      });
    } else {
      setState(() {
        isShowNavBar = true;
      });
    }
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<CoreBloc>(context).add(GetAllProjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => di.sl<CoreBloc>()..add(GetAllProjectsEvent()),
        child: Scaffold(
          backgroundColor: ebonyClay,
          body: _buildBody(),
        ));
  }

  Widget _buildBody() {
    return BlocConsumer<CoreBloc, CoreState>(
      listener: (context, state) {},
      builder: (context, state) {
        final List<Widget> widgetOptions = <Widget>[
          RefreshIndicator(
              backgroundColor: lynch,
              color: goldenRod,
              onRefresh: () => _onRefresh(context),
              child: state.isLoading
                  ? Container(
                      color: ebonyClay,
                      child: const Center(
                          child: CircularProgressIndicator(
                              backgroundColor: lynch, color: goldenRod)))
                  : HomePage(
                      projects: state.projects ?? [], user: widget.user, refreshFunc: (){
                BlocProvider.of<CoreBloc>(context).add(GetAllProjectsEvent());

              })),
          const Center(child: Text('chat screen')),
          AddOrEditProjectPage(returnNavBarFunc: () {
            setState(() {
              isShowNavBar = true;
              _currentIndex = 0;
            });
          },
          refreshFunc: (){
            BlocProvider.of<CoreBloc>(context).add(GetAllProjectsEvent());
          }),
          const Center(child: Text('calendar screen')),
          const Center(child: Text('notifications screen'))
        ];
        return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
                key: scaffoldKey,
                body:
                    (!state.isLoading && state.error == OFFLINE_FAILURE_MESSAGE)
                        ? RefreshIndicator(
                            child: ListView(
                              children: [
                                SizedBox(
                                  height: 200.h,
                                ),
                                const Center(
                                  child: Text("No Internet connection"),
                                )
                              ],
                            ),
                            onRefresh: () => _onRefresh(context))
                        : IndexedStack(
                            index: _currentIndex,
                            children: widgetOptions,
                          ),
                bottomNavigationBar: isShowNavBar
                    ? BottomNavigationBar(
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
                              margin: EdgeInsets.only(top: 15.h),
                              height: 54.w,
                              width: 54.w,
                              color: goldenRod,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: 20.w, maxHeight: 20.w),
                                child: Image.asset(
                                  "assets/icons/add_task_icon.png",
                                ),
                              ),
                            ),
                            label: "",
                          ),
                          //state show just for the club user
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                                "assets/icons/calendar_icon.svg",
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
                      )
                    : null));
      },
    );
  }
}
