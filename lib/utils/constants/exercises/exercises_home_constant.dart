import 'package:flutter/material.dart';

class WorkoutCategory {
  final String title;
  final IconData icon;
  final Color color;

  WorkoutCategory({
    required this.title,
    required this.icon,
    required this.color,
  });
}

final List<WorkoutCategory> categories = [
    WorkoutCategory(
      title: 'Chest',
      icon: Icons.fitness_center,
      color: Colors.cyan,
    ),
    WorkoutCategory(
      title: 'Back',
      icon: Icons.person,
      color: Colors.purple,
    ),
    WorkoutCategory(
      title: 'Shoulders',
      icon: Icons.fitness_center,
      color: Colors.green,
    ),
    WorkoutCategory(
      title: 'Arms',
      icon: Icons.fitness_center,
      color: Colors.white,
    ),
    WorkoutCategory(
      title: 'Legs',
      icon: Icons.fitness_center,
      color: Colors.cyan,
    ),
    WorkoutCategory(
      title: 'Core',
      icon: Icons.bolt,
      color: Colors.purple,
    ),
    WorkoutCategory(
      title: 'Cardio',
      icon: Icons.favorite,
      color: Colors.green,
    ),
    WorkoutCategory(
      title: 'Full Body',
      icon: Icons.person,
      color: Colors.white,
    ),
  ];