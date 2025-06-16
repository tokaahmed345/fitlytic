import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';

double selectedWeight = 0;

class CustomWeightSlider extends StatefulWidget {
  const CustomWeightSlider({super.key});

  @override
  State<CustomWeightSlider> createState() => _CustomWeightSliderState();
}

class _CustomWeightSliderState extends State<CustomWeightSlider> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 60),
          const Center(
            child: Text(
              "What is Your Weight ?",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Your weight is just a number; fitness is the key to turning effort into results and reaching your goals!",
            style: TextStyle(color: AppColor.white70),
          ),
          const SizedBox(height: 100),
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColor.gradientStart,
                  AppColor.gradientEnd,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                Text(
                  '${selectedWeight.toStringAsFixed(1)} kg',
                  style: const TextStyle(fontSize: 20, color: AppColor.white70),
                ),
                Slider(
                  thumbColor: AppColor.thumbColor,
                  activeColor: AppColor.activeSliderColor,
                  max: 200,
                  min: 0,
                  value: selectedWeight,
                  onChanged: (val) {
                    setState(() {
                      selectedWeight = val;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
