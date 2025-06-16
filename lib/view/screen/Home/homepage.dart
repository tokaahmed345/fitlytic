/* last working with heart rate bpm calc */
import 'dart:async';
import 'dart:developer';
import 'package:daily_pedometer2/daily_pedometer2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/core/class/activity_data.dart';
import 'package:flutter_application_depi/core/functions/home_page_functions.dart';
import 'package:flutter_application_depi/core/services/pedometer_service.dart';
import 'package:flutter_application_depi/core/services/services.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/view/screen/Home/goal_setting_screen.dart';
import 'package:flutter_application_depi/view/screen/Home/step_history_screen.dart';
import 'package:flutter_application_depi/view/screen/auth/login.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var prefs = InitServices.sharedPref;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  /* steps constants started */
  late Stream<StepCount> _dailyStepCountStream;
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?', _dailySteps = '?';
  /* steps constants ended */

  /* distance and kcal constants started */
  late final StreamController<ActivityData> _activityStreamController =
      StreamController.broadcast();
  Stream<ActivityData> get activityStream => _activityStreamController.stream;

  final double _height =
      InitServices.sharedPref.getInt("height")!.toDouble(); // cm
  final double _weight =
      InitServices.sharedPref.getDouble("weight")!.toDouble(); // kg
  final String _gender = InitServices.sharedPref.getString("gender")!;
  /* distance and kcal constants ended */

  /* heart constants started*/
  bool isBPMEnabled = false;
  List<SensorValue> data = [];
  List<SensorValue> bpmValues = [];
  String _lastMeasuredBPM = '?';
  /* heart constants ended*/

  final PedometerService _pedometerService = PedometerService();

  late StreamSubscription _stepCountSubscription;
  late StreamSubscription _dailyStepCountSubscription;
  late StreamSubscription _pedestrianStatusSubscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void initPlatformState() async {
    log('INITIALIZING THE STREAMS');

    // Check permission and request if needed
    if (await Permission.activityRecognition.isDenied) {
      await Permission.activityRecognition.request();
    }

    if (!await Permission.activityRecognition.isGranted) return;

    if (!mounted) return;

    // Initialize streams and set up listeners
    _pedestrianStatusSubscription = DailyPedometer2.pedestrianStatusStream
        .listen(onPedestrianStatusChanged, onError: onPedestrianStatusError);
    
    _stepCountSubscription = DailyPedometer2.stepCountStream
        .listen(onStepCount, onError: onStepCountError);
    
    _dailyStepCountSubscription = DailyPedometer2.dailyStepCountStream
        .listen(onDailyStepCount, onError: onDailyStepCountError);
  }

  @override
  void dispose() {
    // Cancel the subscriptions to stop listening when the widget is disposed
    _stepCountSubscription.cancel();
    _dailyStepCountSubscription.cancel();
    _pedestrianStatusSubscription.cancel();
    super.dispose();
  }

  /* steps calc started*/
  void onDailyStepCount(StepCount event) {
    print(event);
    setState(() {
      _dailySteps = event.steps.toString();
      // Update the pedometer service with the latest step count
      _pedometerService.updateTodaySteps(int.parse(_dailySteps));

      final stepsInt = int.tryParse(_dailySteps) ?? 0;
      final activity = calculateDistanceAndCalories(
        steps: stepsInt,
        heightCm: _height,
        weightKg: _weight,
        gender: _gender,
      );
      _activityStreamController.add(activity);
    });
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void onDailyStepCountError(error) {
    print('onDailyStepCountError: $error');
    setState(() {
      _dailySteps = 'Daily Step Count not available';
    });
  }

 
  /* steps calc ended */

  /* heart bpm calc started*/
  void startHeartRateMeasurement() {
    setState(() {
      isBPMEnabled = true;
    });

    // Show a bottom sheet with the camera view
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Color(0xFF1A1D2A),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              isBPMEnabled
                  ? HeartBPMDialog(
                      context: context,
                      showTextValues: true,
                      borderRadius: 10,
                      onRawData: (value) {
                        setState(() {
                          if (data.length >= 100) data.removeAt(0);
                          data.add(value);
                        });
                      },
                      onBPM: (value) => setState(() {
                        if (bpmValues.length >= 100) bpmValues.removeAt(0);
                        bpmValues.add(SensorValue(
                            value: value.toDouble(), time: DateTime.now()));
                        // Update the last measured BPM value
                        _lastMeasuredBPM = value.toString();
                      }),
                    )
                  : const SizedBox(),
              isBPMEnabled && data.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(border: Border.all()),
                      height: 180,
                      child: BPMChart(data),
                    )
                  : const SizedBox(),
              isBPMEnabled && bpmValues.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(border: Border.all()),
                      constraints: const BoxConstraints.expand(height: 180),
                      child: BPMChart(bpmValues),
                    )
                  : const SizedBox(),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.favorite_rounded),
                  label:
                      Text(isBPMEnabled ? "Stop measurement" : "Measure BPM"),
                  onPressed: () => setState(() {
                    if (isBPMEnabled) {
                      isBPMEnabled = false;
                      Navigator.pop(context); // Close the bottom sheet
                    } else {
                      isBPMEnabled = true;
                    }
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// Check camera permission for heart rate monitoring
  Future<bool> checkCameraPermission() async {
    bool granted = await Permission.camera.isGranted;

    if (!granted) {
      granted = await Permission.camera.request() == PermissionStatus.granted;
    }

    return granted;
  }
  /* heart bpm calc ended */



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1D2A),
      appBar: AppBar(
        toolbarHeight: 30.0,
        backgroundColor: const Color(0xFF1A1D2A),
        shadowColor: Colors.transparent,
        title: ShaderMask(
          shaderCallback: (bounds) =>
              AppColor.customGradient.createShader(bounds),
          child: const Text(
            "Fitlytic",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () async {
              // Navigate and wait for result
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const GoalSettingsScreen(),
                ),
              );

              // If goals were updated, refresh data
              if (result == true) {
                // Refresh data
                setState(() {
                  // Re-initialize the platform state to refresh step count
                  initPlatformState();
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              // Save data before navigating
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ),(routes)=>false
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Afternoon, ${prefs.getString("Name")}!',
                        style:const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Ready to crush your goals?',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  // Help tooltip for the user
                  Tooltip(
                    message: "Long press on any metric to set goals",
                    preferBelow: true,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(color: Colors.white),
                    child: const Icon(
                      Icons.help_outline,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Daily metrics rows
              Column(
                children: [
                  // First row with Steps and Calories
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Steps metric card (left side)
                        buildMetricCard(
                          key: const ValueKey('steps'),
                          icon: Icons.directions_walk,
                          value: _dailySteps,
                          label: 'Steps',
                          color: Colors.blue,
                          goal: null,
                          onLongPress: () async {
                            final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const GoalSettingsScreen(),
                              ),
                            );

                            // If goals were updated, refresh data
                            if (result == true) {
                              setState(() {
                                // Re-initialize the platform state to refresh data
                                initPlatformState();
                              });
                            }
                          },
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const StepHistoryScreen(),
                              ),
                            );
                          },
                        ),

                        // Calories metric card (right side)
                        StreamBuilder<ActivityData>(
                          stream: activityStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return buildMetricCard(
                                key: const ValueKey('calories'),
                                icon: Icons.local_fire_department,
                                value: 'Calculating...',
                                label: 'KCalories',
                                color: Colors.redAccent,
                                goal: null,
                                onLongPress: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const GoalSettingsScreen(),
                                    ),
                                  );
                                },
                              );
                            }

                            final data = snapshot.data!;
                            return buildMetricCard(
                              key: const ValueKey('calories'),
                              icon: Icons.local_fire_department,
                              value: data.calories.toStringAsFixed(1),
                              label: 'KCalories',
                              color: Colors.redAccent,
                              goal: null,
                              onLongPress: () async {
                                final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const GoalSettingsScreen(),
                                  ),
                                );

                                // If goals were updated, refresh data
                                if (result == true) {
                                  setState(() {
                                    // Re-initialize the platform state to refresh data
                                    initPlatformState();
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Second row with Distance and Heart Rate
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Distance metric card (left side)
                        StreamBuilder<ActivityData>(
                          stream: activityStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return buildMetricCard(
                                key: const ValueKey('distance_covered'),
                                icon: Icons.directions_walk_rounded,
                                value: 'Calculating...',
                                label: 'Km',
                                color: Colors.greenAccent,
                                goal: null,
                                onLongPress: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const GoalSettingsScreen(),
                                    ),
                                  );
                                },
                              );
                            }

                            final data = snapshot.data!;
                            return buildMetricCard(
                              key: const ValueKey('distance_covered'),
                              icon: Icons.directions_walk_rounded,
                              value: data.distanceKm.toStringAsFixed(2),
                              label: 'Km',
                              color: Colors.greenAccent,
                              goal: null,
                              onLongPress: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const GoalSettingsScreen(),
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        // Heart Rate metric card (right side)
                        InkWell(
                          onTap: () async {
                            bool hasPermission = await checkCameraPermission();
                            if (hasPermission) {
                              startHeartRateMeasurement();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Camera permission is required for heart rate monitoring'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: buildMetricCard(
                            key: const ValueKey('heart_beat'),
                            icon: Icons.favorite,
                            value: _lastMeasuredBPM == '?'
                                ? "0"
                                : _lastMeasuredBPM,
                            label: 'Heart Beat',
                            color: Colors.red,
                            goal: null,
                            onLongPress: () async {
                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const GoalSettingsScreen(),
                                ),
                              );

                              // If goals were updated, refresh data
                              if (result == true) {
                                setState(() {
                                  // Re-initialize the platform state to refresh data
                                  initPlatformState();
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        // Toggle to the other page when back button is pressed
                        _currentPage = 0;
                        // Also update the page controller to match
                        _pageController.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Text(
                    'Recommended Workouts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        // Toggle to the other page when forward button is pressed
                        _currentPage = 1;
                        // Also update the page controller to match
                        _pageController.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Workout cards
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.46,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    // Display plans page
                    categoriesSections(),

                    // Features comparison page
                    difficaltiesSecion(context),
                  ],
                ),
              ),
              const SizedBox(height: 50.0)
            ],
          ),
        ),
      ),
    );
  }
}
