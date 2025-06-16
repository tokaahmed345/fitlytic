import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_wheel_chooser.dart';

int selecteAge = 15;

class CustomAgeColumn extends StatefulWidget {
  const CustomAgeColumn({super.key});

  @override
  State<CustomAgeColumn> createState() => _CustomAgeColumnState();
}

class _CustomAgeColumnState extends State<CustomAgeColumn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 60),
          const Text(
            "Tell Us About Your Age",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Make every year a new opportunity to grow and achieve a healthier, happier life!",
            style: TextStyle(color: AppColor.white70),
          ),
          const SizedBox(height: 50),
          CustomWheelChooser(
            maxValue: 100,
            minValue: 10,
            initValue: selecteAge,
            onValueChanged: (value) {
              setState(() {
                selecteAge = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Text(
            "Age: $selecteAge cm",
            style: const TextStyle(
                color: AppColor.white,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
