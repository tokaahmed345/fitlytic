
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';


class CustomRowButton extends StatelessWidget {
  const CustomRowButton({
    super.key,
    required this.width,
    required this.height,
    required this.onPressed,
     this.onBack,
  });

  final double width;
  final double height;
  final void Function()? onPressed;
  final void Function()? onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onBack,
          child: Text(
            "← Back",
            style: TextStyle(
              color: AppColor.textWhite,
              fontSize: width * 0.045,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.accentPurple,
            foregroundColor: AppColor.textWhite,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.07,
              vertical: height * 0.015,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Text(
            "Next →",
            style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
