import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:volunteer_application/AppConstants/AppConstants.dart';
import 'package:volunteer_application/AuthScreens/sign_up_screen.dart';
import 'package:volunteer_application/NavBar/NavigationBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      FirebaseAuth.instance.currentUser?.uid == null ?
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignUpScreen() ), (route) => false)
      : Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const BottomNavBar()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kColorPrimary,
        child: Center(child: Image.asset('assets/images/logo.png')
            ),
      ),
    );
  }
}
