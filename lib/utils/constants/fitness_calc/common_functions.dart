import 'dart:async';
import 'package:flutter_application_depi/utils/constants/fitness_calc/steps_calc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Add a timer for periodic UI updates
Timer? updateTimer;
int lastRecordedSteps = 0;
DateTime lastStepTime = DateTime.now();

// Load stored data from SharedPreferences
Future<void> loadStoredData() async {
  final prefs = await SharedPreferences.getInstance();

  // Load step count with fallback to default
  lastRecordedSteps = prefs.getInt(STEPS_KEY) ?? 0;
  if (lastRecordedSteps > 0) {
    steps = lastRecordedSteps.toString();
  }

  // Load heart rate with fallback to default
  currentBPM = prefs.getString(BPM_KEY) ?? "72";
}
