import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_hub/utils/images.dart';

import '../introduction_animation/introduction_animation_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    Timer(
      Duration(seconds: 2),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => IntroductionAnimationScreen()),
          (route) => false,
        );
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(logo_resurge_grande, width: 250, fit: BoxFit.cover),
      ),
    );
  }
}
