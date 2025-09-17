import 'package:flutter/material.dart';

class AppColors {
  // White related
  static const Color white = Color(0xFFFFFFFF);
  // If you need the semi-transparent variant from JS:
  static const Color white50 = Color.fromRGBO(255, 255, 255, 0.5);

  // Core dark/neutral
  static const Color black = Color(0xFF202020); // JS: '#202020'
  static const Color black10 = Color.fromRGBO(32, 32, 32, 0.10);

  // Transparent
  static const Color transparent = Color(0x00000000);

  // Primary and accents
  static const Color primary = Color(0xFFFF001F);

  // Light gray tones and others from JS
  static const Color lightGray = Color(0xFFE9E9E9);
  static const Color mercury = Color(0xFFE2E2E2);
  static const Color gray = Color(0xFFB5B5B5);
  static const Color blueChill = Color(0xFF148F96);
  // rgba(20,143,150,0.08)
  static const Color blueChill8 = Color.fromRGBO(20, 143, 150, 0.08);
  static const Color gamboge = Color(0xFFDFA20C);
  static const Color gallery = Color(0xFFEDEDED);
  static const Color snow = Color(0xFFFBFAFA);
  static const Color chinesSilver = Color(0xFFCCCCCC);

  // If you previously had a singleton pattern, you can keep or drop it.
  // Example singleton (optional):
  static final AppColors instance = AppColors._();
  AppColors._();
}
