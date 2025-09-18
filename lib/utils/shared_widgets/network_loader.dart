import 'package:bloc_example/utils/ui_util/app_colors.dart';
import 'package:flutter/material.dart';

class NetworkLoader extends StatelessWidget {
  const NetworkLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
} 