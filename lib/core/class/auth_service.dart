import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_depi/core/services/services.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final prefs= InitServices.sharedPref;

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException {
      rethrow; // Handle errors in the UI layer
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException {
      rethrow; // Handle errors in the UI layer
    }
  }

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    
    if (googleUser == null) {
      // User canceled the sign-in
      return null;
    }

    // 2. Get authentication details
    final GoogleSignInAuthentication googleAuth = 
        await googleUser.authentication;
    
    // 3. Create credential
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // 4. Sign in to Firebase
    final UserCredential userCredential = 
        await FirebaseAuth.instance.signInWithCredential(credential);
    
    // 5. Optional: Check if user exists in your database
    if (userCredential.user == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found after Google sign-in',
      );
    }

    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    // Specific Firebase errors
    throw FirebaseAuthException(
      code: e.code,
      message: 'Google sign-in failed: ${e.message}',
    );
  } on PlatformException catch (e) {
    // Platform-specific errors (like no internet)
    throw FirebaseAuthException(
      code: e.code,
      message: 'Platform error during Google sign-in',
    );
  } catch (e) {
    // Generic catch-all
    throw FirebaseAuthException(
      code: 'unknown-error',
      message: 'Unknown error during Google sign-in',
    );
  }
}Future<User?> signUpWithGoogle() async {
  try {
    // Force the account chooser to always appear
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
      forceCodeForRefreshToken: true,
    );
    
    // Sign out first to ensure the chooser appears
    await googleSignIn.signOut();
    
    // 1. Show Google account chooser dialog
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    
    if (googleUser == null) {
      // User canceled the account selection
      return null;
    }
    

    // 2. Check if user already exists BEFORE authentication
    List<String> methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(googleUser.email);
    if (methods.isNotEmpty) {
      return null;
    }


    // 3. Get authentication details from selected account
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    
    // 4. Create Firebase credential from Google auth tokens
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // 5. Sign up to Firebase with Google credentials
    final UserCredential userCredential = 
        await FirebaseAuth.instance.signInWithCredential(credential);
    
    // 6. Check if user was created successfully
    if (userCredential.user == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found after Google sign-up',
      );
    }
    
    // 7. Send email verification
    await userCredential.user!.sendEmailVerification();
    

    return userCredential.user;
  } on FirebaseAuthException catch (e) {

    throw FirebaseAuthException(
      code: e.code,
      message: 'Google sign-up failed: ${e.message}',
    );
  } on PlatformException catch (e) {
    throw FirebaseAuthException(
      code: e.code,
      message: 'Platform error during Google sign-up: ${e.message}',
    );
  } catch (e) {
    throw FirebaseAuthException(
      code: 'unknown error',
      message: 'Unknown error during Google sign-up: ${e.toString()}',
    );
  }
}
  // Send email verification
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // Sign out
  Future<void> signOut() async {
    prefs.setString("member", "0");
    await _auth.signOut();
    await _googleSignIn.signOut();

  }

  // Check if user is logged in
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Check if email is verified
  bool isEmailVerified() {
    return _auth.currentUser?.emailVerified ?? false;
  }
}