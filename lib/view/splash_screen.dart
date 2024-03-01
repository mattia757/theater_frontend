import 'dart:async';

import 'package:flutter/material.dart';

import '../service/splash_screen_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen ({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenServices _splashScreenServices = SplashScreenServices();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      _splashScreenServices.checkAuthentication(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text("Splash Screen"),
        )
    );
  }
}
