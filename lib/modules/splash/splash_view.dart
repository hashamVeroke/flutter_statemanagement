import 'package:bloc_example/utils/ui_util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Lottie.asset(
          'assets/lottie/splash_screen.json',
        ),
      ),
    );
  }
}