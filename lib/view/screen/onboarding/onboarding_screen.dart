import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/Routes/route.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/cutom_positioned_arrow.dart';

class OnboardingScreen extends StatelessWidget {
  final String id = 'onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: AppColor.blackOpacity,
            ),
          ),
          Positioned.fill(
            top: 100,
            bottom: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Welcome to \nFitlytic 👋! ",
                    style: TextStyle(
                      color: AppColor.purble,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 5,
                        child: Text(
                          "Fitlytic helps track workouts, monitor progress, and optimize fitness. Stay motivated and reach your goals!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight, // Position the arrow on the right
                          child: CustomPositionedArrow(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.pageview);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
