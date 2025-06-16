import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/utils/constants/custom_styles.dart';

// Workout History Page (Image 1)
class WorkoutHistoryPage extends StatelessWidget {
  const WorkoutHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Workout History',
          style: customTitleStyle(24),
        ),
        backgroundColor: const Color(0xFF1F2937),
        elevation: 0,
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
            onPressed: () {},
            tooltip: 'Filter',
          ),
          IconButton(
            icon: const Icon(
              Icons.upload_file,
              color: Colors.white,
            ),
            onPressed: () {},
            tooltip: 'Export',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          buildWorkoutCard(
            icon: Icons.fitness_center,
            title: 'Upper Body Workout',
            subtitle: 'Completed 45 minutes • 320 calories',
            details: ['4 sets • 12 reps', 'High'],
            timeAgo: '2 hours ago',
          ),
          Divider(height: 20, color: Colors.grey[800]),
          buildWorkoutCard(
            icon: Icons.directions_run,
            title: 'Morning Run',
            subtitle: '5.2 km • 32 minutes',
            details: ['6:15 min/km', 'Medium'],
            timeAgo: 'Yesterday',
          ),
          Divider(height: 20, color: Colors.grey[800]),
          buildWorkoutCard(
            icon: Icons.local_fire_department,
            title: 'HIIT Session',
            subtitle: 'Completed 30 minutes • 450 calories',
            details: ['12 rounds', 'High'],
            timeAgo: '2 days ago',
          ),
          Divider(height: 20, color: Colors.grey[800]),
          buildWorkoutCard(
            icon: Icons.self_improvement,
            title: 'Yoga Session',
            subtitle: 'Completed 60 minutes • 180 calories',
            details: ['Vinyasa Flow', 'Low'],
            timeAgo: '3 days ago',
          ),
        ],
      ),
    );
  }

  Widget buildWorkoutCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<String> details,
    required String timeAgo,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon,
              color: icon == Icons.directions_run
                  ? Colors.green
                  : icon == Icons.local_fire_department
                      ? Colors.orange
                      : icon == Icons.self_improvement
                          ? Colors.purple
                          : Colors.blue),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: customTitleStyle(18)),
                  Text(
                    timeAgo,
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
              const SizedBox(height: 8),
              Row(
                children: details.map((detail) {
                  final bool isIntensity =
                      detail == 'High' || detail == 'Medium' || detail == 'Low';
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isIntensity
                            ? (detail == 'High'
                                ? const Color(0xFF374151)
                                : detail == 'Medium'
                                    ? const Color(0xFF374151)
                                    : const Color(0xFF374151))
                            : const Color(0xFF374151),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        detail,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
