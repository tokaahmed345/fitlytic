import 'package:flutter/material.dart';


class CustomTextFormAuth extends StatelessWidget {
  final String hinttext;
  final IconData icondata;
  final TextEditingController? mycontroller;
  final String? Function(String?)? validator;
  final bool isNumber;
  final bool obscureText;
  final String labelText;
  final Color backgroundColor;
  final Color textColor;
  final Color hintColor;
  final Widget? suffixIcon;

  const CustomTextFormAuth({
    super.key,
    required this.hinttext,
    required this.icondata,
    required this.mycontroller,
    required this.validator,
    required this.isNumber,
    this.obscureText = false,
    required this.labelText,
    required this.backgroundColor,
    required this.textColor,
    required this.hintColor,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          validator: validator,
          controller: mycontroller,
          obscureText: obscureText,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: TextStyle(color: hintColor),
            filled: true,
            fillColor: backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(icondata, color: hintColor),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}