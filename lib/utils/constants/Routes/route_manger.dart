


import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/Routes/route.dart';
import 'package:flutter_application_depi/view/screen/Home/homepage.dart';
import 'package:flutter_application_depi/view/screen/Home/start_screen.dart';
import 'package:flutter_application_depi/view/screen/auth/login.dart';
import 'package:flutter_application_depi/view/screen/auth/signup.dart';
import 'package:flutter_application_depi/view/screen/onboarding/age_screen.dart';
import 'package:flutter_application_depi/view/screen/onboarding/gender_screen.dart';
import 'package:flutter_application_depi/view/screen/onboarding/hieght_screen.dart';
import 'package:flutter_application_depi/view/screen/onboarding/onboarding_screen.dart';
import 'package:flutter_application_depi/view/screen/onboarding/page_view_boarding.dart';
import 'package:flutter_application_depi/view/screen/onboarding/weight_screen.dart';
import 'package:flutter_application_depi/view/screen/splash_screen/splashScreen.dart';

class RouteManeger {
 static  Route <dynamic>getRoutes(RouteSettings settings){
    switch(settings.name){
      case Routes.age:
      return MaterialPageRoute(builder:(context)=> AgeScreen() );
      case Routes.gender:
      return MaterialPageRoute(builder: (context)=>GenderScreen());
         case Routes.height:
      return MaterialPageRoute(builder: (context)=> const HeightWheelPicker());
       case Routes.weight:
      return MaterialPageRoute(builder: (context)=> WeightScreen());
      case Routes.onboarnding:
      return MaterialPageRoute(builder: (context)=>const OnboardingScreen());
        case Routes.pageview:
      return MaterialPageRoute(builder: (context)=>const PageViewBoarding());
      case Routes.home:
      return MaterialPageRoute(builder: (context)=>const HomeScreen());
      case Routes.login:
      return MaterialPageRoute(builder: (context)=>const Login());
      case Routes.signup:
      return MaterialPageRoute(builder: (context)=>const Signup());
      case Routes.splashscreen:
      return MaterialPageRoute(builder: (context)=>const Splashscreen());
      case Routes.homeMain:
      return MaterialPageRoute(builder: (context)=> const HomePage());
default:return undefiendroute();

      
    }
  }

static Route  undefiendroute(){
  return MaterialPageRoute(builder: (context)=>Scaffold(appBar: AppBar(title: const Text("UndefiednRoute"),),));
}

}