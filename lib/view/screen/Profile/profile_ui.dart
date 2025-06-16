
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/core/services/services.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/view/screen/Achievement/achievements_screen.dart';
import 'package:flutter_application_depi/view/screen/Home/workout_completion_screen.dart';
import 'package:flutter_application_depi/view/screen/Profile/personal_info.dart';
import 'package:flutter_application_depi/view/screen/Profile/privacy_policy_page.dart';
import 'package:flutter_application_depi/view/screen/Profile/settings_page.dart';
import 'package:flutter_application_depi/view/screen/Profile/support_page.dart';
import 'package:flutter_application_depi/view/screen/Profile/workout_history_page.dart';
import 'package:flutter_application_depi/view/screen/Profile/workout_progress.dart';
import 'package:flutter_application_depi/view/widget/custom_app_bar.dart';

class ProfileUi extends StatefulWidget {
  const ProfileUi({super.key});

  @override
  State<ProfileUi> createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  bool isNotificationEnabled = true;
  final Color darkBackground = const Color(0xFF1A1D2A);
  final Color textColor = Colors.white;
  final Color subtitleColor = Colors.grey.shade400;
  final Color cardBackground = const Color(0xFF242838);
  var prefs=InitServices.sharedPref;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine if screen is small (mobile)
    final isSmallScreen = screenWidth < 600;
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: darkBackground,
        iconTheme: IconThemeData(color: textColor),
        title: CustomAppBar(
          isleadingicon: false,
          istrailingicon: true,
          title: "Profile",
          textColor: textColor,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: cardBackground,
              child: Icon(Icons.person, size: 40, color: textColor),
            ),
            const SizedBox(height: 10),
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColor.customGradient.createShader(bounds),
              child: Text(
                prefs.getString("Name")!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            Text(
              'Lose a Fat Program',
              style: TextStyle(color: subtitleColor),
            ),
            const SizedBox(height: 10),
           
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileInfoCard(
                  label: 'Height', 
                  value: prefs.getInt("height"),
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                ),
                ProfileInfoCard(
                  label: 'Weight',
                  value:  prefs.getDouble("weight"),
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                ),
                ProfileInfoCard(
                  label: 'Age', 
                  value: prefs.getInt("age"),
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                ),
              ],
            ),
            const SizedBox(height: 20),
            buildSection('Account', [
              {'title': 'Personal Data', 'icon': Icons.person, 'ontap': () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PersonalInfo(),
                    ),
                  );
              }},
              {'title': 'Achievement', 'icon': Icons.emoji_events, 'ontap': () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AchievementsScreen(),
                    ),
                  );
              }},
              {'title': 'Activity History', 'icon': Icons.history, 'ontap': () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const WorkoutHistoryPage(),
                    ),
                  );
              }},
              {'title': 'Workout Progress', 'icon': Icons.fitness_center, 'ontap': () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const WorkoutProgress(),
                    ),
                  );
              }},
            ]),
            const SizedBox(height: 20),
            buildNotificationSection(),
            const SizedBox(height: 20),
            buildSection('Other', [
              {
                'title': 'Contact Us',
                'icon': Icons.contact_mail,
                'ontap': () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SupportPage(),
                    ),
                  );
                }
              },
              {
                'title': 'Privacy Policy',
                'icon': Icons.privacy_tip,
                'ontap': () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyPage(),
                    ),
                  );
                }
              },
              {'title': 'Settings', 'icon': Icons.settings, 'ontap': () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
              }},
            ]),
            SizedBox(
              height: isSmallScreen? MediaQuery.of(context).size.height * 0.11 : MediaQuery.of(context).size.height * 0.26,
            )
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColor.customGradient.createShader(bounds),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ...items.map((item) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: cardBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            onTap: item['ontap'],
            leading: ShaderMask(
              shaderCallback: (bounds) =>
                  AppColor.customGradient.createShader(bounds),
              child: Icon(item['icon'], color: Colors.white),
            ),
            title: Text(
              item['title'],
              style: TextStyle(color: textColor),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios, 
              size: 16, 
              color: subtitleColor,
            ),
          ),
        )),
      ],
    );
  }

  Widget buildNotificationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColor.customGradient.createShader(bounds),
          child: Text(
            'Notification',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: cardBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: ShaderMask(
              shaderCallback: (bounds) =>
                  AppColor.customGradient.createShader(bounds),
              child: const Icon(Icons.notifications, color: Colors.white),
            ),
            title: Text(
              'Pop-up Notification',
              style: TextStyle(color: textColor),
            ),
            trailing: Switch(
              value: isNotificationEnabled,
              onChanged: (value) {
                setState(() {
                  isNotificationEnabled = value;
                });
              },
              activeColor: Colors.purple,
              activeTrackColor: Colors.purple.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final String label;
  var value;
  final Color textColor;
  final Color subtitleColor;

  ProfileInfoCard({
    super.key, 
    required this.label, 
    required this.value,
    required this.textColor,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF242838),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.blue, Colors.purple],
            ).createShader(bounds),
            child: Text(
              value.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: subtitleColor),
          ),
        ],
      ),
    );
  }
}