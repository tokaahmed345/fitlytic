
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/core/functions/achievements_screen.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldColor,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Achievements',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Track your fitness milestones',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {
              // Profile action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),

              // Achievement cards
              buildAchievementCard(
                title: 'Workout Warrior',
                description: 'Complete 100 workouts',
                icon: Icons.emoji_events,
                progress: 1.0,
                progressText: '100% Complete',
                iconColor: Colors.amber,
              ),
              const SizedBox(height: 16),

              buildAchievementCard(
                title: 'Early Bird',
                description: 'Complete 10 workouts before 7 AM',
                icon: Icons.wb_sunny,
                progress: 1.0,
                progressText: '100% Complete',
                iconColor: Colors.blue,
              ),
              const SizedBox(height: 16),

              buildAchievementCard(
                title: 'Marathon Ready',
                description: 'Run a total of 100 kilometers',
                icon: Icons.track_changes,
                progress: 0.65,
                progressText: '65% Complete',
                iconColor: Colors.blue,
                locked: false,
              ),
              const SizedBox(height: 16),

              buildAchievementCard(
                title: 'Strength Master',
                description: 'Lift 1000kg total in a single workout',
                icon: Icons.fitness_center,
                progress: 0.45,
                progressText: '45% Complete',
                iconColor: Colors.blue,
                locked: false,
              ),
              const SizedBox(height: 24),

              // Level progress
              buildLevelProgress(
                level: 12,
                xp: 1250,
                maxXp: 2000,
              ),
              const SizedBox(
                height: 100.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
