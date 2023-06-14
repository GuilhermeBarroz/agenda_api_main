import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login.view.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4), () {
      Get.to(const LoginView());
    });
    return const Scaffold(
      backgroundColor: Color(0xFFededed),
      body: Center(
        child: Image(image: AssetImage("assets/splash.gif")),
      ),
    );
  }
}
