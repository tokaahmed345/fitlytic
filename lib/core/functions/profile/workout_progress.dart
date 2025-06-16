
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';

Widget buildHeader(void Function()? onPressed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        hoverColor: AppColor.grey2,
        iconSize: 24.0,
        onPressed: onPressed,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      const Text(
        "Weekly Report",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: const Text(
          "View All",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    ],
  );
}

Widget buildStatsRow() {
  return Row(
    children: [
      Expanded(
        child: buildStatCard(
          icon: Icons.bar_chart,
          iconColor: Colors.blue,
          title: "Weekly Progress",
          value: "85%",
          change: "+5%",
          isPositive: true,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: buildStatCard(
          icon: Icons.local_fire_department,
          iconColor: Colors.orange,
          title: "Calories Burned",
          value: "12,450",
          change: "+2,300",
          isPositive: true,
        ),
      ),
    ],
  );
}

Widget buildStatCard({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String value,
  required String change,
  required bool isPositive,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF212936),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              change,
              style: TextStyle(
                fontSize: 12,
                color: isPositive ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildWorkoutDistribution() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF212936),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Weekly Workout Distribution",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const titles = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                      return Text(
                        titles[value.toInt()],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      );
                    },
                    reservedSize: 30,
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: [
                buildBarGroup(0, 10),
                buildBarGroup(1, 8),
                buildBarGroup(2, 12),
                buildBarGroup(3, 7),
                buildBarGroup(4, 15),
                buildBarGroup(5, 6),
                buildBarGroup(6, 4),
              ],
              gridData: const FlGridData(show: false),
            ),
          ),
        ),
      ],
    ),
  );
}

BarChartGroupData buildBarGroup(int x, double y) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.lightBlue],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        width: 20,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
    ],
  );
}

Widget buildExerciseDistribution() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF212936),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Exercise Distribution",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        buildExerciseRow("Strength Training", 0.4, "40%"),
        const SizedBox(height: 12),
        buildExerciseRow("Cardio", 0.3, "30%"),
        const SizedBox(height: 12),
        buildExerciseRow("HIIT", 0.2, "20%"),
        const SizedBox(height: 12),
        buildExerciseRow("Flexibility", 0.1, "10%"),
      ],
    ),
  );
}

Widget buildExerciseRow(String title, double progress, String percentage) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          Text(
            percentage,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      LinearProgressIndicator(
        value: progress,
        backgroundColor: Colors.grey[800],
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        minHeight: 8,
        borderRadius: BorderRadius.circular(4),
      ),
    ],
  );
}
