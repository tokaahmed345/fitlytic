// ignore_for_file: prefer_is_not_empty, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/core/functions/validinput.dart';
import 'package:flutter_application_depi/view/screen/auth/login.dart';
import 'package:flutter_application_depi/view/widget/auth/custombuttonauth.dart';
import 'package:flutter_application_depi/view/widget/auth/customtextformauth.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final TextEditingController emailController = TextEditingController();
  final _textFormKey = GlobalKey<FormState>(); // Key for the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141B2D),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: const Center(
                  child: Text(
                    "Enter Your Email For",
                    style: TextStyle(fontSize: 25, color: Colors.white70),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: const Center(
                  child: Text(
                    "Password Reset",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Form(
            key: _textFormKey, // Assign the form key
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  CustomTextFormAuth(
                    labelText: "Email",
                    hinttext: "Enter Your Email To check",
                    icondata: Icons.email,
                    isNumber: false,
                    mycontroller: emailController,
                    validator: (val) => Validinput("email", emailController.text),
                    backgroundColor: AppColor.textFormBackgroundColor,
                    textColor: Colors.white,
                    hintColor: Colors.white38,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 400,
                    child: CustomButtonAuth(
                      backgroundColor: Colors.transparent,
                      onPressed: () async {
                        // Validate the form
                        if (!(emailController.text.isEmpty)) {
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: emailController.text);
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.rightSlide,
                              dialogType: DialogType.info,
                              titleTextStyle: const TextStyle(color: Colors.red),
                              title: 'Attention!!',
                              desc: "Check Your Email For Password Reset",
                            ).show();
                          } catch (e) {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.leftSlide,
                              dialogType: DialogType.info,
                              titleTextStyle: const TextStyle(color: Colors.red),
                              title: 'Error!!',
                              desc: "Please Enter Right Email!!",
                            ).show();
                          }
                        } else {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.leftSlide,
                            dialogType: DialogType.info,
                            titleTextStyle: const TextStyle(color: Colors.red),
                            title: 'Error!!',
                            desc:
                                "Please Enter Your Email First Then Press Forget Password",
                          ).show();
                        }
                      },
                      text: 'Submit',
                      gradient: AppColor.customGradient,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 400,
                    child: CustomButtonAuth(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Login.id);
                        // Navigate to the login screen
                      },
                      text: 'Back To Login',
                      backgroundColor: Colors.transparent,
                      gradient: AppColor.customGradient,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
