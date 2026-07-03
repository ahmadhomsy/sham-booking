import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class AppDecorations {
  AppDecorations._();

  static const BoxDecoration splashDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.primaryContainer, AppColors.secondaryContainer],
    ),
  );
  static final BoxDecoration containerLogoDecoration = BoxDecoration(
    color: AppColors.backgroundStart,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.2),
        blurRadius: 15,
        offset: const Offset(0, 5),
      ),
    ],
  );
  static final BoxDecoration glassDecoration = BoxDecoration(
    color: Colors.white.withValues(alpha: 0.05),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: Colors.white.withValues(alpha: 0.15),
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryContainer.withValues(
          alpha: 0.2,
        ),
        blurRadius: 30,
        spreadRadius: 5,
      ),
    ],
  );
  static const BoxDecoration backgroundDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
    ),
  );
}
