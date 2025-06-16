import 'package:flutter/material.dart';
import 'package:flutter_application_depi/core/functions/profile/workout_progress.dart';

class WorkoutProgress extends StatelessWidget {
  const WorkoutProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F2B),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader((() {
                  Navigator.of(context).pop();
                })),
                const SizedBox(height: 16),
                buildStatsRow(),
                const SizedBox(height: 16),
                buildWorkoutDistribution(),
                const SizedBox(height: 16),
                buildExerciseDistribution(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
