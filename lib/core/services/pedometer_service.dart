import 'dart:io';
import 'package:daily_pedometer2/daily_pedometer2.dart';
import 'package:flutter_application_depi/core/services/services.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:path_provider/path_provider.dart';

class PedometerService {
  static final PedometerService _instance = PedometerService._internal();

  factory PedometerService() {
    return _instance;
  }

  PedometerService._internal();

  // Default daily step goal
   int goal = InitServices.sharedPref.getInt("stepsGoal") ?? 10000;

  // Cache for the current day's steps
  int _todaySteps = 0;

  // Get current step count from the homepage stream
  void updateTodaySteps(int steps) {
    _todaySteps = steps;
    // Save the steps to file whenever we get an update
    _saveStepData(DateTime.now(), steps);
  }

  // Get today's step count
  int get todaySteps => _todaySteps;

  // Save step data to local storage
  Future<void> _saveStepData(DateTime date, int steps) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/step_history.json');

      // Format the date as YYYY-MM-DD for consistent storage
      final dateKey = DateFormat('yyyy-MM-dd').format(date);

      Map<String, dynamic> historyData = {};

      // Read existing data if file exists
      if (await file.exists()) {
        final contents = await file.readAsString();
        historyData = json.decode(contents);
      }

      // Update or add today's steps
      historyData[dateKey] = steps;

      // Write back to file
      await file.writeAsString(json.encode(historyData));
      developer.log('Saved step data: $dateKey - $steps steps');
    } catch (e) {
      developer.log('Error saving step data: $e', error: e);
    }
  }

  // Get step history for the last 7 days
  Future<List<MapEntry<DateTime, int>>> getLast7DaysHistory() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/step_history.json');

      // Initialize with empty data for past 7 days
      final now = DateTime.now();
      final Map<String, int> weekData = {};

      // Create entries for the last 7 days
      for (int i = 6; i >= 0; i--) {
        final date = DateTime(now.year, now.month, now.day - i);
        final dateKey = DateFormat('yyyy-MM-dd').format(date);
        weekData[dateKey] = 0; // Default to 0 steps
      }

      // Read saved data if file exists
      if (await file.exists()) {
        final contents = await file.readAsString();
        final Map<String, dynamic> historyData = json.decode(contents);

        // Update weekData with saved values
        historyData.forEach((key, value) {
          if (weekData.containsKey(key)) {
            weekData[key] = value;
          }
        });
      }

      // Create sorted list of MapEntry<DateTime, int>
      final sortedEntries = weekData.entries.map((entry) {
        return MapEntry(DateFormat('yyyy-MM-dd').parse(entry.key), entry.value);
      }).toList()
        ..sort((a, b) => a.key.compareTo(b.key));

      return sortedEntries;
    } catch (e) {
      developer.log('Error getting step history: $e', error: e);
      // Return empty data on error
      return List.generate(7, (index) {
        final date = DateTime.now().subtract(Duration(days: 6 - index));
        return MapEntry(date, 0);
      });
    }
  }

  // Get a stream of daily step counts from the pedometer
  Stream<StepCount> getDailyStepCountStream() {
    return DailyPedometer2.dailyStepCountStream;
  }

  // Clear all stored step data (for testing or reset)
  Future<void> clearStepHistory() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/step_history.json');
      if (await file.exists()) {
        await file.delete();
        developer.log('Step history cleared');
      }
    } catch (e) {
      developer.log('Error clearing step history: $e', error: e);
    }
  }
}
