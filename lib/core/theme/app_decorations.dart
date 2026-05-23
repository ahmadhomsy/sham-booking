import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class AppDecorations {
  AppDecorations._();

  static BoxDecoration splashDecoration = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.deepSapphireBlue, AppColors.darkGradientEnd],
    ),
  );
  static BoxDecoration containerLogoDecoration = BoxDecoration(
    color: AppColors.softSand, // Soft Sand
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.2),
        blurRadius: 15,
        offset: const Offset(0, 5),
      ),
    ],
  );
  static BoxDecoration glassDecoration = BoxDecoration(
    color: Colors.white.withValues(alpha: 0.05),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: Colors.white.withValues(alpha: 0.15),
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.deepSapphireBlue.withValues(
          alpha: 0.2,
        ),
        blurRadius: 30,
        spreadRadius: 5,
      ),
    ],
  );
}
