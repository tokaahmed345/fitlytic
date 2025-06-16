
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_depi/view/screen/Achievement/achievements_screen.dart';
import 'package:flutter_application_depi/view/screen/Activity/activity_tracker.dart';
import 'package:flutter_application_depi/view/screen/Home/homepage.dart';
import 'package:flutter_application_depi/view/screen/Profile/profile_ui.dart';
import 'package:flutter_application_depi/view/screen/search/search_screen.dart';
import 'package:flutter_application_depi/view/widget/home/custom_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int activeIndex = 0;
  var _bottomNavIndex = 0;

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: customFloatingActionButton(() {
        _fabAnimationController.reset();
        _borderRadiusAnimationController.reset();
        _borderRadiusAnimationController.forward();
        _fabAnimationController.forward();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customAnimatedBottomBar(
          _bottomNavIndex,
          (index) => setState(() {
                _bottomNavIndex = index;
              }),
          _hideBottomBarAnimationController),
      body: _bottomNavIndex == 0
          ?  const HomeScreen()
          : _bottomNavIndex == 1
              ? const ActivityTrackerScreen()
              : _bottomNavIndex == 2
                  ? const AchievementsScreen()
                  : const ProfileUi(),
    );
  }
}
