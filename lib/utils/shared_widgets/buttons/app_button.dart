import 'package:bloc_example/utils/ui_util/app_colors.dart';
import 'package:bloc_example/utils/text_style_util.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? color;
  final bool disabled;
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Opacity(
        opacity: disabled ? 0.8 : 1.0,
        child: ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? AppColors.primary,
            foregroundColor: AppColors.white,
            textStyle: TextStyleUtil.semiBold18,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(title),
        ),
      ),
    );
  }
}
