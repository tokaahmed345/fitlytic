
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/model/exercise_model.dart';
import 'package:flutter_application_depi/view/screen/search/search_helper.dart/exercise_details_helper.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  const ExerciseDetailsScreen({super.key, required this.excersice});

  final ExcersiceModel excersice;

  @override
  Widget build(BuildContext context) {
    final detailsWidgets = ExerciseDetailsHelper.buildDetailsWidgets(excersice);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D14),
      appBar: AppBar(
        title: Text(
          excersice.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0D0D14),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: detailsWidgets.length,
          itemBuilder: (context, index) => detailsWidgets[index],
        ),
      ),
    );
  }
}
