import 'package:flutter/material.dart';

import 'package:flutter_application_depi/core/services/services.dart';
import 'package:flutter_application_depi/utils/constants/exercises/exercises_home_constant.dart';
import 'package:flutter_application_depi/view/screen/Home/exercises/exercises_home.dart';
import 'package:flutter_application_depi/view/screen/excercies_in_homepage/exercise_home.dart';


Widget buildMetricCard({
  required Key key,
  required IconData icon,
  required String value,
  required String label,
  required Color color,
  var goal,
  Function? onLongPress,
   void Function()? onTap
}) {
  // Get saved user goals from SharedPreferences
  var prefs = InitServices.sharedPref;
  
  // Default goals for each metric
  final dynamic defaultGoal = label == 'Steps'
      ? prefs.getInt("stepsGoal") ?? 10000
      : label == 'KCalories'
          ? prefs.getDouble("caloriesGoal") ?? 600.0
          : label == 'Km'
              ? prefs.getDouble("distanceGoal") ?? 5.0
              : label == 'Heart Beat'
                  ? prefs.getInt("heartRateGoal") ?? 80
                  : 100;

  // Use provided goal or default
  var targetGoal = goal ?? defaultGoal;

  // Calculate progress
  double progress = 0.0;
  if (value != "?" && value != "Step Count not available" && value != "Calculating...") {
    // Try parsing as double first (works for both integers and decimals)
    double? currentValue = double.tryParse(value);
    
    if (currentValue != null) {
      // For heart rate, optimal is around the goal (not necessarily higher is better)
      if (label == 'Heart Beat') {
        // Consider target as optimal - too high or too low is not ideal
        double deviation = (currentValue - targetGoal).abs() / targetGoal;
        progress = 1.0 - deviation.clamp(0.0, 1.0);
      } else {
        progress = currentValue / targetGoal;
      }

      // Clamp progress between 0 and 1
      progress = progress.clamp(0.0, 1.0);
    }
  }

  return InkWell(
    onTap: label.contains('Steps')? onTap : null,
    onLongPress: () {
      if (onLongPress != null) {
        onLongPress();
      }
    },
    child: Column(
      key: key,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey[800],
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Icon(
                icon,
                color: color,
                size: 24,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label == 'Steps'
              ? (value != "?" ? "$value / $targetGoal" : "0 / $targetGoal")
              : (label == 'KCalories'
                  ? "$value / $targetGoal"
                  : label == 'Km'
                      ? "$value / $targetGoal km"
                      : label == 'Heart Beat'
                          ? "$value bpm"
                          : value),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

Widget categoriesSections() {
  return GridView.builder(
    shrinkWrap: true, // Make GridView take only the space it needs
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
    ),
    itemCount: categories.length,
    itemBuilder: (context, index) {
      return CategoryCard(category: categories[index]);
    },
  );
}

Widget difficaltiesSecion(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        buildWorkoutCard(
          key: const ValueKey('workout_3'),
          title: 'Yoga Flow',
          trainer: 'Emma Wilson',
          duration: '20 min',
          difficulty: 'easy',
          image: 'assets/achievement/strength_2.jpg',
          onTap: () async {
            // Save data before navigation
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseListScreen(
                  difficulty: 'Easy',
                  exercises: easyExercises,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        buildWorkoutCard(
          key: const ValueKey('workout_1'),
          title: 'HIIT Cardio Blast',
          trainer: 'Sarah Johnson',
          duration: '30 min',
          difficulty: 'medium',
          image: 'assets/achievement/strength_2.jpg',
          onTap: () async {
            // Save data before navigation
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseListScreen(
                  difficulty: 'Medium',
                  exercises: mediumExercises,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        buildWorkoutCard(
          key: const ValueKey('workout_2'),
          title: 'Strength Foundation',
          trainer: 'Mike Chen',
          duration: '45 min',
          difficulty: 'Hard',
          image: 'assets/achievement/strength_2.jpg',
          onTap: () async {
            // Save data before navigation
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseListScreen(
                  difficulty: 'Advanced',
                  exercises: advancedExercises,
                ),
              ),
            );
          },
        )
      ],
    ),
  );
}

Widget buildWorkoutCard({
  required Key key,
  required String title,
  required String trainer,
  required String duration,
  required String difficulty,
  required String image,
  void Function()? onTap,
}) {
  Color difficultyColor;
  if (difficulty == 'easy') {
    difficultyColor = Colors.green;
  } else if (difficulty == 'medium') {
    difficultyColor = Colors.orange;
  } else {
    difficultyColor = Colors.red;
  }

  return GestureDetector(
    key: key,
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF222533),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              image,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: difficultyColor,
                      ),
                      child: Text(
                        difficulty.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey[700],
                      child: Text(
                        trainer[0], // Show trainer's initial
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      trainer,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
