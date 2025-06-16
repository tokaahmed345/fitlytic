import 'package:flutter/material.dart';

class CustomLoginLinks extends StatelessWidget {
  final String img;
  final void Function()? onTap;

  const CustomLoginLinks({
    super.key,
    required this.img,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Image.asset(
            img,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}