import 'package:bloc_example/utils/ui_util/app_colors.dart';
import 'package:flutter/material.dart';

class BlockingLoader extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const BlockingLoader({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.4), // ✅ updated
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
