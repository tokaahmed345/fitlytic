import 'package:flutter/material.dart';
import 'package:flutter_application_depi/core/services/services.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/view/screen/Profile/edit_personal_info.dart';

class PersonalInfo extends StatelessWidget {
  PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1D2A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile header
                ProfileHeader(),
                const SizedBox(height: 16),

                // Metrics Grid
                const MetricsGrid(),
                const SizedBox(height: 16),

                // Personal Information Section
                PersonalInformationCard(),
                const SizedBox(height: 16),

                // Weekly Activity Section
                const WeeklyActivityCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});
  var prefs = InitServices.sharedPref;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
            radius: 30,
            backgroundColor: AppColor.secBlue,
            child: Icon(
              Icons.person_2,
              size: 40,
            )),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              prefs.getString("Name")!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.primaryBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Intermediate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.primaryBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Weight Loss',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            // padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColor.primaryBlue,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const EditPersonalInfoPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              ),
            )),
      ],
    );
  }
}

class MetricsGrid extends StatelessWidget {
  const MetricsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 130),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        MetricCard(
          icon: Icons.monitor_heart_outlined,
          title: 'Daily Activity',
          value: '78%',
          progressValue: 0.78,
          progressColor: AppColor.primaryBlue,
          isProgress: true,
        ),
        MetricCard(
          icon: Icons.favorite_outline,
          title: 'Heart Rate',
          value: '72',
          unit: 'bpm',
          progressColor: Colors.redAccent,
        ),
        MetricCard(
          icon: Icons.directions_walk,
          title: 'Steps',
          value: '8,432',
          progressColor: AppColor.primaryBlue,
        ),
        MetricCard(
          icon: Icons.local_fire_department_outlined,
          title: 'Calories',
          value: '2,150',
          progressColor: Colors.orangeAccent,
        ),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String? unit;
  final double? progressValue;
  final Color progressColor;
  final bool isProgress;

  const MetricCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.unit,
    this.progressValue,
    required this.progressColor,
    this.isProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.containerColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: isProgress
          ? Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(icon, color: progressColor, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 22.0,
                    ),
                    Center(
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  top: 25.0,
                  left: 30.0,
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: progressValue,
                      strokeWidth: 8,
                      backgroundColor: Colors.white10,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: progressColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (unit != null)
                          TextSpan(
                            text: ' $unit',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class PersonalInformationCard extends StatelessWidget {
  var prefs = InitServices.sharedPref;
  PersonalInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.containerColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Information',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // First row: Age, Height, Weight
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PersonalInfoItem(title: "Age", value: prefs.getInt("age")),
              PersonalInfoItem(title: 'Height', value: prefs.getInt("height")),
              PersonalInfoItem(
                  title: 'Weight', value: prefs.getDouble("weight")!),
            ],
          ),
          const SizedBox(height: 24),

          // Second row: BMI, Activity Level, Goal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PersonalInfoItem(title: 'BMI', value: '24.5'),
              PersonalInfoItem(
                  title: 'Activity Level', value: 'Moderately Active'),
              PersonalInfoItem(title: 'Goal', value: 'Weight Loss'),
            ],
          ),
        ],
      ),
    );
  }
}

class PersonalInfoItem extends StatelessWidget {
  final String title;
  var value;

  PersonalInfoItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class WeeklyActivityCard extends StatelessWidget {
  const WeeklyActivityCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data for activity levels
    final List<double> activityLevels = [0.6, 0.5, 0.8, 0.4, 0.9, 0.7, 0.6];
    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.containerColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Activity',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                days.length,
                (index) => ActivityBar(
                  day: days[index],
                  level: activityLevels[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityBar extends StatelessWidget {
  final String day;
  final double level;

  const ActivityBar({
    super.key,
    required this.day,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 35,
          height: 100 * level,
          decoration: BoxDecoration(
            color: AppColor.primaryBlue,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
