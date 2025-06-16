// Settings Page (Image 2 & 3 combined)
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/core/functions/profile/settings_page.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/utils/constants/custom_styles.dart';
import 'package:flutter_application_depi/view/screen/Profile/support_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String profileVisibility = 'Public';
  String activityVisibility = 'Everyone';
  bool darkMode = true;
  bool workoutReminders = true;
  bool progressUpdates = true;
  bool achievementAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
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
        centerTitle: true,
        backgroundColor: const Color(0xFF1F2937),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Account Settings
          buildSettingsSection(
            icon: Icons.person,
            title: 'Account Settings',
            children: [
              buildSettingItem(
                title: 'Profile Visibility',
                subtitle: 'Control who can see your profile',
                trailing: buildDropdown(
                  value: profileVisibility,
                  items: ['Public', 'Friends Only', 'Private'],
                  onChanged: (value) {
                    setState(() {
                      profileVisibility = value!;
                    });
                  },
                ),
              ),
              buildSettingItem(
                title: 'Email Notifications',
                subtitle: 'Receive email updates about your account',
                trailing: null,
              ),
            ],
          ),

          // Appearance
          buildSettingsSection(
            icon: Icons.dark_mode,
            title: 'Appearance',
            children: [
              buildSettingItem(
                title: 'Dark Mode',
                subtitle: 'Toggle dark mode on or off',
                trailing: Switch(
                  value: darkMode,
                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                    });
                  },
                  activeColor: const Color(0xFF3B82F6),
                ),
              ),
            ],
          ),

          // Notifications
          buildSettingsSection(
            icon: Icons.notifications,
            title: 'Notifications',
            children: [
              buildSettingItem(
                title: 'Workout Reminders',
                subtitle: 'Get notified about scheduled workouts',
                trailing: Switch(
                  value: workoutReminders,
                  onChanged: (value) {
                    setState(() {
                      workoutReminders = value;
                    });
                  },
                  activeColor: const Color(0xFF3B82F6),
                ),
              ),
              buildSettingItem(
                title: 'Progress Updates',
                subtitle: 'Receive updates about your fitness progress',
                trailing: Switch(
                  value: progressUpdates,
                  onChanged: (value) {
                    setState(() {
                      progressUpdates = value;
                    });
                  },
                  activeColor: const Color(0xFF3B82F6),
                ),
              ),
              buildSettingItem(
                title: 'Achievement Alerts',
                subtitle: 'Get notified when you earn achievements',
                trailing: Switch(
                  value: achievementAlerts,
                  onChanged: (value) {
                    setState(() {
                      achievementAlerts = value;
                    });
                  },
                  activeColor: const Color(0xFF3B82F6),
                ),
              ),
            ],
          ),

          // Privacy
          buildSettingsSection(
            icon: Icons.lock,
            title: 'Privacy',
            children: [
              buildSettingItem(
                title: 'Activity Visibility',
                subtitle: 'Control who can see your activities',
                trailing: buildDropdown(
                  value: activityVisibility,
                  items: ['Everyone', 'Friends', 'Only Me'],
                  onChanged: (value) {
                    setState(() {
                      activityVisibility = value!;
                    });
                  },
                ),
              ),
              buildSettingItem(
                title: 'Data Sharing',
                subtitle: 'Manage how your data is shared',
                trailing: null,
              ),
            ],
          ),

          // Support button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  gradient: AppColor.customGradient),
              clipBehavior: Clip.antiAlias,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SupportPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Contact Support', style: customTitleStyle(16.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  
}
