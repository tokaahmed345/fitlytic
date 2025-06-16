// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:flutter_application_depi/core/class/auth_service.dart';
import 'package:flutter_application_depi/core/functions/validinput.dart';
import 'package:flutter_application_depi/core/services/services.dart';
import 'package:flutter_application_depi/view/screen/auth/login.dart';
import 'package:flutter_application_depi/view/widget/auth/custombuttonauth.dart';
import 'package:flutter_application_depi/view/widget/auth/customloginlinks.dart';
import 'package:flutter_application_depi/view/widget/auth/customtextformauth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  static const String id = "/signup";

  @override
  // ignore: library_private_types_in_public_api
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dateController = TextEditingController();
  var prefs = InitServices.sharedPref;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  bool _isLoading = false;

  DateTime? _selectedDate;
  final AuthService _authService = AuthService();

  bool _isSequential(String password) {
    if (password.length < 3) return false;
    for (int i = 0; i < password.length - 1; i++) {
      if ((password.codeUnitAt(i) + 1 != password.codeUnitAt(i + 1)) &&
          (password.codeUnitAt(i) - 1 != password.codeUnitAt(i + 1))) {
        return false;
      }
    }
    return true;
  }

  Future<void> _signUpWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _authService.signUpWithGoogle();
      if (user == null) {
        AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.error,
              title: 'Attention!!',
              desc: "User Email is already exist. Please try another email.",
            ).show();

      } else {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          title: 'Success!!',
          desc:
              "You have successfully signed up with Google and will be redirected to the login page.",
        ).show();
        setState(() {
          _isLoading = false;
        });

        await Future.delayed(
          const Duration(seconds: 2),
          () {
            prefs.setString("Name", "Not Defined");
            Navigator.pushReplacementNamed(context, Login.id);
          },
        );
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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF3B82F6),
              onPrimary: Colors.white,
              surface: Color(0xFF1D2639),
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF3B82F6),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // Manual date formatting (MM/dd/yyyy)
        _dateController.text = '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
  }

  Future<void> _signUpWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = await _authService.signUpWithEmailAndPassword(
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
            desc:
                "You need to verify your email then go to login page.Check your inbox.",
          ).show();
          await Future.delayed(
          const Duration(seconds: 2),
          () {
            prefs.setString("Name", _nameController.text);
            Navigator.pushReplacementNamed(context, Login.id);
          },
        );
        } else {
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.info,
            title: 'Error!!',
            desc: "Something went wrong. Please try again.",
          ).show();
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = "An error occurred. Please try again.";
        if (e.code == 'weak-password') {
          errorMessage = "The password provided is too weak.";
        } else if (e.code == 'email-already-in-use') {
          errorMessage = "The account already exists for that email.";
        }
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          title: 'Error!!',
          desc: errorMessage,
        ).show();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.authBackgroundColor,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 40),
                    // Logo and Title
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColor.customGradient.createShader(bounds),
                      child: const Center(
                        child: Text(
                          "Fitlytic",
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        'Join Us & Start Your Fitness Journey Today!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Signup Form
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D2639),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Full Name Field
                            CustomTextFormAuth(
                              hinttext: "Enter your full name",
                              icondata: Icons.person,
                              isNumber: false,
                              mycontroller: _nameController,
                              validator: (val) =>
                                  Validinput("name", _nameController.text),
                              labelText: 'Full Name',
                              backgroundColor: AppColor.textFormBackgroundColor,
                              textColor: Colors.white,
                              hintColor: Colors.white38,
                            ),
                            const SizedBox(height: 16),

                            // Email Field
                            CustomTextFormAuth(
                              hinttext: "abc1123@gmail.com",
                              icondata: Icons.email,
                              isNumber: false,
                              mycontroller: _emailController,
                              validator: (val) =>
                                  Validinput("email", _emailController.text),
                              labelText: 'Email',
                              backgroundColor: AppColor.textFormBackgroundColor,
                              textColor: Colors.white,
                              hintColor: Colors.white38,
                            ),
                            const SizedBox(height: 16),

                            // Password Field
                            CustomTextFormAuth(
                              hinttext: "Enter your password",
                              icondata: Icons.lock,
                              isNumber: false,
                              obscureText: _obscurePassword,
                              mycontroller: _passwordController,
                              validator: (val) => Validinput(
                                  "password", _passwordController.text),
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
                            const SizedBox(height: 4),
                            // Password strength indicator
                            if (_passwordController.text.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (_isSequential(_passwordController.text))
                                    const Text(
                                      'Avoid using sequential passwords like "abc" or "6543".',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.red),
                                    )
                                  else
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LinearProgressIndicator(
                                          value: _getPasswordStrength(),
                                          backgroundColor: Colors.grey[800],
                                          color: _getPasswordColor(),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _getPasswordStrength() < 0.3
                                              ? 'Weak password'
                                              : _getPasswordStrength() < 0.7
                                                  ? 'Good password'
                                                  : 'Strong password',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _getPasswordColor(),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            const SizedBox(height: 16),

                            // Confirm Password Field
                            CustomTextFormAuth(
                              hinttext: "Confirm your password",
                              icondata: Icons.lock,
                              isNumber: false,
                              obscureText: _obscureConfirmPassword,
                              mycontroller: _confirmPasswordController,
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              labelText: 'Confirm Password',
                              backgroundColor: AppColor.textFormBackgroundColor,
                              textColor: Colors.white,
                              hintColor: Colors.white38,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white54,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 16),

                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: CustomTextFormAuth(
                                  hinttext: 'mm/dd/yyyy',
                                  icondata: Icons.calendar_today,
                                  isNumber: false,
                                  mycontroller: _dateController,
                                  validator: (val) =>
                                      Validinput("date", _dateController.text),
                                  labelText: 'Date of Birth',
                                  backgroundColor:
                                      AppColor.textFormBackgroundColor,
                                  textColor: Colors.white,
                                  hintColor: Colors.white38,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Terms and Conditions Checkbox
                            Row(
                              children: [
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Checkbox(
                                    value: _agreeToTerms,
                                    onChanged: (value) {
                                      setState(() {
                                        _agreeToTerms = value ?? false;
                                      });
                                    },
                                    fillColor: WidgetStateProperty.resolveWith(
                                      (states) {
                                        if (states
                                            .contains(WidgetState.selected)) {
                                          return const Color(0xFF3B82F6);
                                        }
                                        return Colors.transparent;
                                      },
                                    ),
                                    side:
                                        const BorderSide(color: Colors.white54),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'I agree to the ',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Terms & Conditions',
                                          style: TextStyle(
                                            color: Color(0xFF3B82F6),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(text: ' and '),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: TextStyle(
                                            color: Color(0xFF3B82F6),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Create Account Button
                            CustomButtonAuth(
                              onPressed: _isLoading
                                  ? null
                                  : _agreeToTerms
                                      ? _signUpWithEmailAndPassword
                                      : () {
                                          AwesomeDialog(
                                            context: context,
                                            animType: AnimType.scale,
                                            dialogType: DialogType.warning,
                                            title: 'Notice',
                                            desc:
                                                'You must agree to the terms and conditions to proceed.',
                                          ).show();
                                        },
                              text: "Create Account",
                              backgroundColor: Colors.transparent,
                              gradient: AppColor.customGradient,
                            ),
                            const SizedBox(height: 20),

                            // Or sign up with
                            const Row(
                              children: [
                                Expanded(child: Divider(color: Colors.white24)),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    'Or sign up with',
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(child: Divider(color: Colors.white24)),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Social Sign Up Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomLoginLinks(
                                  onTap: _isLoading ? null : _signUpWithGoogle,
                                  img: "assets/images/google_icon.png",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sign In Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              color: Color(0xFF3B82F6),
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  double _getPasswordStrength() {
    final String password = _passwordController.text;
    if (password.isEmpty) return 0;
    if (password.length < 4) return 0.2;
    if (password.length < 6) return 0.4;
    if (password.length < 8) return 0.6;
    if (_hasVariety(password)) return 1.0;
    return 0.8;
  }

  bool _hasVariety(String password) {
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialChars = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    return (hasUppercase && hasLowercase && (hasDigits || hasSpecialChars));
  }

  Color _getPasswordColor() {
    final double strength = _getPasswordStrength();
    if (strength < 0.3) return Colors.red;
    if (strength < 0.6) return Colors.orange;
    if (strength < 0.8) return Colors.yellow;
    return Colors.green;
  }
}

// Reuse the same custom components from your login page
