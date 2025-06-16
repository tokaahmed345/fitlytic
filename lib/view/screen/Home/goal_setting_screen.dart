import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_application_depi/core/services/services.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';

class GoalSettingsScreen extends StatefulWidget {
  static const String id = "GoalSettingsScreen";
  const GoalSettingsScreen({super.key});

  @override
  State<GoalSettingsScreen> createState() => _GoalSettingsScreenState();
}

class _GoalSettingsScreenState extends State<GoalSettingsScreen> {
  // Controllers for text fields
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();

  // Keys for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Load saved goals from SharedPreferences
    _loadSavedGoals();
  }

  void _loadSavedGoals() {
    var prefs = InitServices.sharedPref;

    // Get saved goals or use defaults
    _stepsController.text = (prefs.getInt("stepsGoal") ?? 10000).toString();
    _caloriesController.text =
        (prefs.getDouble("caloriesGoal") ?? 600.0).toString();
    _distanceController.text =
        (prefs.getDouble("distanceGoal") ?? 5.0).toString();
    _heartRateController.text =
        (prefs.getInt("heartRateGoal") ?? 80).toString();
  }

  Future<void> _saveGoals() async {
    if (_formKey.currentState!.validate()) {
      var prefs = InitServices.sharedPref;

      // Save all goals
      await prefs.setInt("stepsGoal", int.parse(_stepsController.text));
      await prefs.setDouble(
          "caloriesGoal", double.parse(_caloriesController.text));
      await prefs.setDouble(
          "distanceGoal", double.parse(_distanceController.text));
      await prefs.setInt("heartRateGoal", int.parse(_heartRateController.text));

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Goals saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Return true to indicate goals were updated
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  void dispose() {
    _stepsController.dispose();
    _caloriesController.dispose();
    _distanceController.dispose();
    _heartRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1D2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1D2A),
        title: ShaderMask(
          shaderCallback: (bounds) =>
              AppColor.customGradient.createShader(bounds),
          child: const Text(
            "Set Your Goals",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context, false), // Return false if back button pressed without saving
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Introduction text
                const Text(
                  'Customize your daily fitness goals',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),

                // Steps Goal
                _buildGoalField(
                  title: 'Daily Steps',
                  icon: Icons.directions_walk,
                  color: Colors.blue,
                  controller: _stepsController,
                  hint: '10000',
                  isInteger: true,
                ),

                // Calories Goal
                _buildGoalField(
                  title: 'Calories (kcal)',
                  icon: Icons.local_fire_department,
                  color: Colors.redAccent,
                  controller: _caloriesController,
                  hint: '600',
                ),

                // Distance Goal
                _buildGoalField(
                  title: 'Distance (km)',
                  icon: Icons.directions_walk_rounded,
                  color: Colors.greenAccent,
                  controller: _distanceController,
                  hint: '5.0',
                ),

                // Heart Rate Goal
                _buildGoalField(
                  title: 'Target Heart Rate (bpm)',
                  icon: Icons.favorite,
                  color: Colors.red,
                  controller: _heartRateController,
                  hint: '80',
                  isInteger: true,
                ),

                const SizedBox(height: 40),

                // Save Button
                Center(
                  child: ElevatedButton(
                    onPressed: _saveGoals, // Fixed: was _saveGoals; (missing parentheses)
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Save Goals',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoalField({
    required String title,
    required IconData icon,
    required Color color,
    required TextEditingController controller,
    required String hint,
    bool isInteger = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF222533),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextFormField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              keyboardType: isInteger
                  ? TextInputType.number
                  : const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                isInteger
                    ? FilteringTextInputFormatter.digitsOnly
                    : FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                }

                if (isInteger) {
                  int? intValue = int.tryParse(value);
                  if (intValue == null || intValue <= 0) {
                    return 'Please enter a valid positive number';
                  }
                } else {
                  double? doubleValue = double.tryParse(value);
                  if (doubleValue == null || doubleValue <= 0) {
                    return 'Please enter a valid positive number';
                  }
                }

                return null;
              },
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(
                  icon,
                  color: color,
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}