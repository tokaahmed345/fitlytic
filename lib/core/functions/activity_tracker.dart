import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/activity_tracker.dart';
Widget buildBarChart() {
    // Define different patterns based on the selected time frame
    List<double> values;
    List<String> labels;
    switch (selectedTimeFrame) {
      case 'Day':
        values = [3, 7, 4, 6, 2, 5, 4, 8, 5, 3, 6, 4];
        labels = List.generate(12, (index) => '${index * 2}h');
        break;
      case 'Week':
        values = [6, 8, 3, 1, 4, 7, 6];
        labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        break;
      case 'Month':
        values = [
          5,
          3,
          2,
          6,
          3,
          6,
          8,
          5,
          7,
          4,
          6,
          5,
          3,
          4,
          2,
          5,
          3,
          6,
          7,
          5,
          4,
          3,
          5,
          7,
          4,
          8,
          6,
          5,
          4,
          3
        ];
        labels = List.generate(30, (index) => '${index + 1}');
        break;
      case 'Custom':
        values = [4, 5, 2, 7, 3, 5, 8];
        labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        break;
      default:
        values = [6, 8, 3, 1, 4, 7, 6];
        labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    }

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 10,
        barGroups: List.generate(
          values.length,
          (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: values[index],
                color: const Color(0xFF2C3D5B),
                width: selectedTimeFrame == 'Month' ? 6 : 20,
                borderRadius: BorderRadius.zero,
              ),
            ],
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (selectedTimeFrame == 'Month' &&
                    value % 5 != 0 &&
                    value != 0) {
                  return const SizedBox(); // Only show every 5th label for month view
                }
                return Text(
                  labels[value.toInt()],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                );
              },
            ),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  Widget buildPieChart() {
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 60,
        sections: [
          PieChartSectionData(
            value: 45,
            color: Colors.blue,
            radius: 20,
            showTitle: false,
          ),
          PieChartSectionData(
            value: 30,
            color: Colors.green,
            radius: 20,
            showTitle: false,
          ),
          PieChartSectionData(
            value: 25,
            color: Colors.red,
            radius: 20,
            showTitle: false,
          ),
        ],
      ),
    );
  }

  Widget buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
              fontSize: 12, color: Colors.white), // Added white color
        ),
      ],
    );
  }

  Widget buildWorkoutCard({
    required String title,
    required String instructor,
    required String calories,
    required String duration,
    required double rating,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF242A38),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.show_chart,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white, // Added white color
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  instructor,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  calories,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Added white color
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  duration,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Wrap the star rating with MainAxisSize.min
          Container(
            constraints: const BoxConstraints(maxWidth: 80),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }