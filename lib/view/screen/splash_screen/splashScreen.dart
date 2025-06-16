import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_application_depi/core/services/services.dart';
import 'package:flutter_application_depi/view/screen/auth/login.dart';

import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});
  static const String id="/";
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final prefs = InitServices.sharedPref;
  @override
  void initState() {
    // TODO: implement initState
    prefs.setString("splash", "1");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset('assets/splash.json', width: 650, height: 650),
      ),
      nextScreen: const Login(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: const Color.fromARGB(255, 4, 44, 78),
      duration: 3000,
      splashIconSize: 200.0,
    );
  }
}
