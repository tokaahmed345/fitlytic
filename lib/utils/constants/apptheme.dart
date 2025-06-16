import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';

ThemeData themeEnglish=ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "playfairDisplay",
        textTheme: const TextTheme(
          headlineMedium: TextStyle(height: 2,fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20,),
          headlineLarge: TextStyle(height: 2,fontWeight: FontWeight.bold,color: Colors.black,fontSize: 26,),
          bodyMedium: TextStyle(color: AppColor.grey,height: 2,fontWeight: FontWeight.bold,fontSize: 17,),
        )
      );
ThemeData themeArabic=ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Cairo",
        textTheme: const TextTheme(
          headlineMedium: TextStyle(height: 2,fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20,),
          headlineLarge: TextStyle(height: 2,fontWeight: FontWeight.bold,color: Colors.black,fontSize: 26,),
          bodyMedium: TextStyle(color: AppColor.grey,height: 2,fontWeight: FontWeight.bold,fontSize: 17,),
        )
      );