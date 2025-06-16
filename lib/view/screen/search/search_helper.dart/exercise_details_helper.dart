
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/model/exercise_model.dart';
import 'package:flutter_application_depi/view/widget/exercise_details/card_list.dart';
import 'package:flutter_application_depi/view/widget/exercise_details/custom_body_details.dart';
import 'package:flutter_application_depi/view/widget/exercise_details/section_title.dart';

class ExerciseDetailsHelper {
  // دالة ثابتة لتكوين الـ detailsWidgets
  static List<Widget> buildDetailsWidgets(ExcersiceModel excersice) {
    return [
      // Center(
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(16),
      //     child: Image.network(
      //       excersice.gifUrl!,
      //       height: 200,
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      // ),
      const SizedBox(height: 24),
      const SectionTitle(title: "🎯 Target Muscle"),
      ...excersice.targetMuscles!.map((e) => DetailsCardList(
            icon: Icons.bolt,
            color: Colors.purple,
            text: e,
          )),
      const SectionTitle(title: "💪 Secondary Muscles"),
      ...excersice.secondaryMuscles!.map((e) => DetailsCardList(
            icon: Icons.fitness_center,
            color: Colors.blue,
            text: e,
          )),
      const SectionTitle(title: "🧍 Body Part"),
      ...excersice.bodyParts!.map((e) => DetailsCardList(
            icon: Icons.accessibility_new,
            color: Colors.orange,
            text: e,
          )),
      const SectionTitle(title: "🛠 Equipment"),
      ...excersice.equipments!.map((e) => DetailsCardList(
            icon: Icons.build,
            color: Colors.teal,
            text: e,
          )),
      const SectionTitle(title: "📋 Instructions"),
      ...excersice.instructions!.map((e) => CustomBodyDetails(title: e)),
    ];
  }
}
