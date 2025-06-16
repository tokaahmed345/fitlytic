import 'package:flutter/material.dart';

import 'package:flutter_application_depi/core/services/services.dart';
import 'package:flutter_application_depi/utils/constants/Routes/route.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_buttons.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_select_gender.dart';

class GenderScreen extends StatefulWidget {
  static String id = "GenderPage";
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? selectedGender;
  var prefs=InitServices.sharedPref;

  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: AppColor.blackOpacity,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/gender.png',
                fit: BoxFit.cover,
              ),
            ),

            Positioned.fill(
              child: Container(
                color: AppColor.blackOpacity,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.025,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.05),
                  Text(
                    "Your gender",
                    style: TextStyle(
                      color: AppColor.textWhite,
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    "To estimate your body’s",
                    style: TextStyle(
                      color: AppColor.textGrey,
                      fontSize: width * 0.045,
                    ),
                  ),
                  Text(
                    "metabolic rate.",
                    style: TextStyle(
                      color: AppColor.textGrey,
                      fontSize: width * 0.045,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  GenderSelected(
                    gender: "Male",
                    isSelected: selectedGender == "Male",
                    onTap: () => _selectGender("Male"),
                  ),
                  SizedBox(height: height * 0.02),
                  GenderSelected(
                    gender: "Female",
                    isSelected: selectedGender == "Female",
                    onTap: () => _selectGender("Female"),
                  ),
                  const Spacer(),
                  CustomRowButton(
                    onBack: (){
                      Navigator.of(context).pop();
                    },
                    onPressed: () {
                      if(selectedGender != null){
                        prefs.setString("gender", selectedGender!);
                      Navigator.pushNamed(context, Routes.weight);
                      }
                    },
                    width: width,
                    height: height,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
