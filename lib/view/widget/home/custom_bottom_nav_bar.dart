//bottom navigation bar section
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

List<IconData> bottomIconList = [
  Icons.home_outlined,
  Icons.directions_run,
  Icons.emoji_events,
  Icons.person_2
];

Widget customFloatingActionButton(void Function()? onPressed) {
  return SizedBox(
    width: 70,
    height: 70,
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 2, 29, 52),
            Color.fromARGB(255, 195, 0, 229)
          ], // Your gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const CircleBorder(),
        onPressed: onPressed,
        child: const Icon(
          Icons.search,
          size: 30,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget customAnimatedBottomBar(int bottomNavIndex, dynamic Function(int) onTap,
    AnimationController? hideBottomBarAnimationController) {
  return AnimatedBottomNavigationBar.builder(
    itemCount: bottomIconList.length,
    tabBuilder: (int index, bool isActive) {
      if (isActive) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [
                Color.fromARGB(255, 195, 0, 229),
                Color.fromARGB(255, 10, 98, 176),
              ], // Use the same gradient colors
            ).createShader(bounds);
          },
          child: Icon(
            bottomIconList[index],
            size: 30,
            color: Colors.white, // White base to apply gradient
          ),
        );
      } else {
        return Icon(
          bottomIconList[index],
          size: 30,
          color: Colors.white, // Default inactive color
        );
      }
    },
    height: 80.0,
    backgroundColor: const Color(0xFF1F2937),
    activeIndex: bottomNavIndex,
    gapLocation: GapLocation.center,
    notchSmoothness: NotchSmoothness.verySmoothEdge,
    leftCornerRadius: 32,
    rightCornerRadius: 32,
    splashSpeedInMilliseconds: 300,
    onTap: onTap,
    hideAnimationController: hideBottomBarAnimationController,
  );
}
