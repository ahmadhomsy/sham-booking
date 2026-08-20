import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class DecorativeCircles extends StatelessWidget {
  const DecorativeCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -50,
          right: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryContainer.withValues(alpha: 0.2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.3),
                  blurRadius: 60,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          left: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer.withValues(alpha: 0.1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryContainer.withValues(alpha: 0.15),
                  blurRadius: 60,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
