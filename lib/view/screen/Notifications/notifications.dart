import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/view/screen/Notifications/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1D2A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    hoverColor: AppColor.grey2,
                    iconSize: 24.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: const Text(
                  //     'Mark all as read',
                  //     style: TextStyle(color: Colors.white70),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '2 unread notifications',
                style: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: const [
                    NotificationCard(
                      icon: '🎯',
                      title: 'Daily Goal Achieved!',
                      message:
                          'Congratulations! You\'ve reached your daily step goal of 10,000 steps.',
                      timeAgo: '2 hours ago',
                      isUnread: true,
                    ),
                    SizedBox(height: 12),
                    NotificationCard(
                      icon: '👍',
                      title: 'New Workout Available',
                      message:
                          'Check out the new HIIT workout program designed for your fitness level.',
                      timeAgo: '5 hours ago',
                      isUnread: true,
                    ),
                    SizedBox(height: 12),
                    NotificationCard(
                      icon: '🏆',
                      title: 'Achievement Unlocked',
                      message:
                          'You\'ve earned the "Early Bird" badge for completing 5 morning workouts!',
                      timeAgo: 'Yesterday',
                      isUnread: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

