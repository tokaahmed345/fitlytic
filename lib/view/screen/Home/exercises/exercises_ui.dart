import 'package:flutter/material.dart';
import 'package:flutter_application_depi/controller/exercise_cubit.dart';
import 'package:flutter_application_depi/controller/exercise_state.dart';
import 'package:flutter_application_depi/model/exercise_model.dart';
import 'package:flutter_application_depi/view/screen/search/search_view.dart';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseCategoryScreen extends StatefulWidget {
  final String categoryTitle;

  const ExerciseCategoryScreen({
    super.key,
    required this.categoryTitle,
  });

  @override
  State<ExerciseCategoryScreen> createState() => _ExerciseCategoryScreenState();
}

class _ExerciseCategoryScreenState extends State<ExerciseCategoryScreen> {
  String searchQuery = '';
  String selectedCategory = '';
  String selectedEquipment = "All Equipment";
  List<ExcersiceModel> exercises = [];
  String? firstCatName = "";
  String? secondCatName;

  // List of all possible categories
  final List<String> categories = [
    'All Muscle Groups',
    'Chest',
    'Back',
    'Shoulders',
    'Arms',
    'Legs',
    'Core',
    'Cardio',
    'Full Body'
  ];

  // List of all possible equipment types
  final List<String> equipmentTypes = [
    'All Equipment',
    'Barbell',
    'Body weight',
    'Dumbbell',
    'Kettlebell'
  ];
  void getRealName() {
    if (widget.categoryTitle == "Arms") {
      firstCatName = "arms";
    } else if (widget.categoryTitle == 'Back') {
      firstCatName = "back";
    } else if (widget.categoryTitle == 'Shoulders') {
      firstCatName = "shoulders";
      secondCatName = null;
    } else if (widget.categoryTitle == 'Legs') {
      firstCatName = "legs";
      secondCatName = null;
    } else if (widget.categoryTitle == 'Full Body') {
      secondCatName = null;
    } else if (widget.categoryTitle == 'Chest') {
      firstCatName = "chest";
      secondCatName = null;
    } else if (widget.categoryTitle == 'Core') {
      firstCatName = "waist";
      secondCatName = null;
    } else if (widget.categoryTitle == 'Cardio') {
      firstCatName = "cardio";
      secondCatName = null;
    } else {
      firstCatName = "Unknown";
      secondCatName = null;
    }
  }

  @override
  void initState() {
    super.didChangeDependencies();
    super.initState();
    getRealName();
    // print("===================================================hi1");
    // print("${context.read<ExerciseCubit>().state}===========================");
    // print("$firstCatName $secondCatName ====================================");
    context.read<ExerciseCubit>().filterByTargetMuscle(firstCatName,
        secondTargetedMuscle: secondCatName);

    selectedCategory = widget.categoryTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1D2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1D2A),
        title: Text(
          "$selectedCategory Exercises",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: BlocBuilder<ExerciseCubit, ExerciseState>(
                builder: (context, state) {
                  if (state is ExerciseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ExerciseLoaded) {
                    return Text(
                      "there are ${state.exercises.length} Exercises available for this category",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    );
                  } else {
                    return Container();
                  }
                },
              )),
          // Search bar

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SearchView(),
          ),

          // Filter options in a row
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF222533),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        isExpanded: true,
                        dropdownColor: const Color(0xFF222533),
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: Colors.white),
                        items: categories.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          // You'll add your category filter logic here
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF222533),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedEquipment,
                        isExpanded: true,
                        dropdownColor: const Color(0xFF222533),
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: Colors.white),
                        items: equipmentTypes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          // You'll add your equipment filter logic here
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ExerciseCubit, ExerciseState>(
              builder: (context, state) {
                if (state is ExerciseLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ExerciseLoaded) {
                  final exercises = state.exercises;
                  // Apply your filters here if needed
                  return exercises.isEmpty
                      ? const Center(
                          child: Text(
                            'No exercises found',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.75,
                                  mainAxisExtent:
                                      MediaQuery.of(context).size.height *
                                          0.44),
                          itemCount: exercises.length,
                          itemBuilder: (context, index) {
                            return ExerciseCard(
                              exercise: exercises[index],
                            );
                          },
                        );
                } else if (state is ExerciseError) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final ExcersiceModel exercise;

  const ExerciseCard({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF222533),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                'assets/profile/gym.jpg',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children:[ Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name!, // You'll replace with dynamic title
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      // Tags are rendered here - you'll populate dynamically
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          // Sample tag - you'll populate from your API
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              "Target muscle is ${exercise.bodyParts![0]}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBarAnimationStyle: AnimationStyle(
                                    curve: Curves.easeIn,
                                    reverseCurve: Curves.easeOut),
                                SnackBar(
                                    // backgroundColor: AppColor.primaryPurple,
                                    content: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: exercise.instructions!.length,
                                        itemBuilder: (context, index) {
                                          return Text(
                                              "${exercise.instructions![index]}");
                                        })));
                          },
                          label: const Text("View Instructions",style: TextStyle(fontSize: 12),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.cyan,
                            elevation: 1,
                            maximumSize: const Size(double.infinity, 10),
                            side: const BorderSide(color: Colors.cyan),
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            minimumSize: const Size(double.infinity, 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable widget for displaying exercise instructions dialog
Widget buildInstructionsDialog(BuildContext context, dynamic exercise) {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
    child: Dialog(
      backgroundColor: const Color(0xFF222533),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 250),
                      child: const Text(
                        "Exercise Title", // Replace with dynamic title
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left column - Exercise image
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/exercises/placeholder.jpg", // Replace with dynamic image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Right column - Instructions
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Instructions',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Sample instruction - you'll populate from your API
                        buildNumberedInstruction(1, "Sample instruction step"),
                        buildNumberedInstruction(2, "Another sample step"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Target muscles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Target Muscles',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      // Sample muscle - you'll populate from your API
                      buildMuscleTag("Sample Muscle", Colors.purple),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Secondary muscles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Secondary Muscles',
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      // Sample secondary muscle - you'll populate from your API
                      buildMuscleTag("Sample Secondary", Colors.cyan),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Equipment
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Equipment',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      // Sample equipment - you'll populate from your API
                      buildMuscleTag("Sample Equipment", Colors.green),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}

// Helper widget for numbered instructions
Widget buildNumberedInstruction(int number, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.purple,
          ),
          child: Center(
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper widget for muscle tags
Widget buildMuscleTag(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.3),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color),
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
