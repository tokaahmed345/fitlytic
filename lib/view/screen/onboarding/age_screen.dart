import 'package:flutter/material.dart';
import 'package:flutter_application_depi/core/services/services.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/view/screen/auth/welcome_screen.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_buttons.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_age_column.dart';

class AgeScreen extends StatelessWidget {
  var prefs = InitServices.sharedPref;
  AgeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    final padding = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: AppColor.primaarybg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
              const Expanded(child: CustomAgeColumn()),
              CustomRowButton(
                onBack: () {
                  Navigator.of(context).pop();
                },
                width: screenWidth,
                height: screenHeight,
                onPressed: () {
                  prefs.setInt("age", selecteAge);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
