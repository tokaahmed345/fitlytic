import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';

class CustomPositionedArrow extends StatelessWidget {
  const CustomPositionedArrow({super.key, required this.onPressed});
final  void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return   Positioned(
            right: 10, 
            bottom: 50, 
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.overlayBackgroundGreyDark,
              ),
              child: IconButton(
                onPressed:onPressed ,
                icon: const Icon(Icons.arrow_forward_ios, size: 40, color: Colors.white),
              ),
            ),
          );
  }
}