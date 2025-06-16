import 'package:flutter/material.dart';
import 'package:heart_bpm/heart_bpm.dart' as heart_bpm;

// Keys for SharedPreferences
const String BPM_KEY = 'heart_rate_bpm';
const String LAST_UPDATED_KEY = 'last_updated';

// Heart rate monitoring variables
List<heart_bpm.SensorValue> heartData = [];
List<heart_bpm.SensorValue> bpmValues = [];
bool isBPMEnabled = false;
String currentBPM = "72"; // Default value
Widget? heartRateDialog;
