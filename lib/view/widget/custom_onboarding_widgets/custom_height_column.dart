import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_wheel_chooser.dart';

int selectedHeight = 150;

class CustomHeightColumn extends StatefulWidget {
  const CustomHeightColumn({super.key});

  @override
  State<CustomHeightColumn> createState() => _CustomHeightColumnState();
}

class _CustomHeightColumnState extends State<CustomHeightColumn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 60),
          const Text(
            "What is Your Height?",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Your height is a key part of your fitness journey!",
            style: TextStyle(color: AppColor.white70),
          ),
          const SizedBox(height: 50),
          CustomWheelChooser(
            maxValue: 220,
            minValue: 100,
            initValue: selectedHeight,
            onValueChanged: (value) {
              setState(() {
                selectedHeight = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Text(
            "Height: $selectedHeight cm",
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
