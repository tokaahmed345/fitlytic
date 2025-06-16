import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';

class CustomTextBodyAuth extends StatelessWidget {
  final String text;
  const CustomTextBodyAuth({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(text,textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColor.grey),),
          );
  }
}