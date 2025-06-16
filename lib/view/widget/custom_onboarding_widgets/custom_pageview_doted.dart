
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/model/onboardingmodel.dart';

class CustomPageViewDotted extends StatelessWidget {
  const CustomPageViewDotted({
    super.key,
    required int currentPage,
  }) : _currentPage = currentPage;

  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onBoardingData.length,
        (i) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == _currentPage
                ? const Color(0xFFB76EFF)
                : i < _currentPage
                    ? Colors.white
                    : const Color(0xFF4A4A80),
          ),
        ),
      ),
    );
  }
}
