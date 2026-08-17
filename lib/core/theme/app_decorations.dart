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
  static final BoxDecoration hotelCardDecoration = BoxDecoration(
    color: AppColors.surfaceContainerLowest,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.transparent),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryContainer.withValues(alpha: 0.04),
        blurRadius: 20,
        offset: const Offset(0, 4),
      ),
    ],
  );
  static final BoxDecoration gradientOverlay = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        AppColors.primaryContainer.withValues(alpha: 0.8),
        Colors.transparent,
      ],
    ),
  );
  static final BoxDecoration mapHotelSummaryCardDecoration = BoxDecoration(
    color: AppColors.surfaceContainerLowest,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.15),
        blurRadius: 15,
        offset: const Offset(0, 5),
      ),
    ],
  );
  static final BoxDecoration profileHeaderDecoration = BoxDecoration(
    color: const Color(0xFFFBF4D8),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: const Color(0x33D4AF37),
    ),
  );
  static final BoxDecoration helpCenterCardDecoration = BoxDecoration(
    color: AppColors.surfaceContainerLowest,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryContainer.withValues(alpha: 0.04),
        blurRadius: 20,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static final BoxDecoration iconSecondaryFixedDecoration = BoxDecoration(
    color: AppColors.secondaryFixed.withValues(alpha: 0.3),
    borderRadius: BorderRadius.circular(12),
  );

  static final BoxDecoration needHelpContainerDecoration = BoxDecoration(
    color: AppColors.surfaceContainerLow,
    borderRadius: BorderRadius.circular(16),
  );

  static final BoxDecoration bottomNavDecoration = BoxDecoration(
    color: AppColors.surfaceContainerLowest,
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryContainer.withValues(alpha: 0.05),
        blurRadius: 10,
        offset: const Offset(0, -2),
      ),
    ],
  );

  static final BoxDecoration navItemActiveDecoration = BoxDecoration(
    color: AppColors.secondaryContainer,
    borderRadius: BorderRadius.circular(24),
  );
}
