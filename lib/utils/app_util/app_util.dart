import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../shared_widgets/network_loader.dart';

class AppUtil {
  static bool isTestEnvironment = false;

  /// Check if the platform is iOS
  static bool isIOS() {
    return defaultTargetPlatform == TargetPlatform.iOS;
  }

  /// Update status bar
  static void updateStatusBar() {
    // Implementation for status bar update
  }

  // --- Validators ---
  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  ///loader for the app
  static void showLoader({
    required BuildContext? context,
    bool startLoad = true,
    bool barrierDismissible = false,
  }) {
    if (context == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) {
        return const PopScope(
          canPop: false,
          child: Center(
            child: Stack(children: <Widget>[NetworkLoader()]),
          ),
        );
      },
    );
  }

  ///dismiss the loader if showing

  /// Show a success popup

  /// Show an error popup
}
