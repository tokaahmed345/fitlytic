// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_application_depi/utils/constants/Routes/route.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/core/class/auth_service.dart';
import 'package:flutter_application_depi/core/services/services.dart';
import 'package:flutter_application_depi/view/screen/Home/start_screen.dart';
import 'package:flutter_application_depi/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:flutter_application_depi/core/functions/validinput.dart';
import 'package:flutter_application_depi/view/screen/auth/signup.dart';
import 'package:flutter_application_depi/view/widget/auth/custombuttonauth.dart';
import 'package:flutter_application_depi/view/widget/auth/customloginlinks.dart';
import 'package:flutter_application_depi/view/widget/auth/customtextformauth.dart';
class Login extends StatefulWidget {
  const Login({super.key});
  static const String id = "/login";

  @override
  // ignore: library_private_types_in_public_api
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false;
  final prefs = InitServices.sharedPref;
  
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = await _authService.signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );

        if (user != null && !user.emailVerified) {
          await _authService.sendEmailVerification();
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.info,
            title: 'Attention!!',
            desc: "Verification code sent to your email",
          ).show();
        } else {
          if(prefs.getString("member") != "1"){
            prefs.setString("member","1");
            Navigator.pushNamedAndRemoveUntil(context, Routes.onboarnding, (route) => false);
          }else{
            Navigator.pushNamedAndRemoveUntil(context, Routes.homeMain, (route) => false);
          }
        }
      } on FirebaseAuthException catch (e) {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          title: 'Error!!',
          desc: e.message ?? "An error occurred",
        ).show();
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        if(prefs.getString("member") == "1"){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const HomePage()));
          
        }else{
          prefs.setString("member","1");
          Navigator.pushNamedAndRemoveUntil(context, Routes.onboarnding, (route) => false);
          
        }
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.error,
        title: 'Error!!',
        desc: e.toString(),
      ).show();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.authBackgroundColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  "Fitlytic",
                  style: TextStyle(fontSize: 20, color: Colors.white70),
                ),
              ),
              const Center(
                child: Text(
                  "Welcome Back! Ready to Crush Your Fitness Goals?",textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    CustomTextFormAuth(
                      hinttext: "abc1123@gmail.com",
                      icondata: Icons.email,
                      isNumber: false,
                      mycontroller: _emailController,
                      validator: (val) => Validinput("email", _emailController.text),
                      labelText: 'Email',
                      backgroundColor: AppColor.textFormBackgroundColor,
                      textColor: Colors.white,
                      hintColor: Colors.white38,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormAuth(
                      hinttext: "Enter Your Password",
                      icondata: Icons.lock,
                      isNumber: false,
                      obscureText: _obscurePassword,
                      mycontroller: _passwordController,
                      validator: (val) => Validinput("password", _passwordController.text),
                      labelText: 'Password',
                      backgroundColor: AppColor.textFormBackgroundColor,
                      textColor: Colors.white,
                      hintColor: Colors.white38,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                    prefs.setString("remember", "1");
                                    
                                  });
                                },
                                fillColor: WidgetStateProperty.resolveWith(
                                  (states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return const Color(0xFF3B82F6);
                                    }
                                    return Colors.transparent;
                                  },
                                ),
                                side: const BorderSide(color: Colors.white54),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ResetPassword()),
                            );
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: Color(0xFF3B82F6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    CustomButtonAuth(
                      onPressed: _isLoading ? null : _loginWithEmailAndPassword,
                      text: "Login",
                      backgroundColor: Colors.transparent,
                      gradient: AppColor.customGradient,
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "Or Login With",
                        style: TextStyle(fontSize: 20, color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        CustomLoginLinks(
                          onTap: _isLoading ? null : _loginWithGoogle,
                          img: "assets/images/google_icon.png",
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have account?",
                          style: TextStyle(fontSize: 20, color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Signup.id);
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF3B82F6),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


