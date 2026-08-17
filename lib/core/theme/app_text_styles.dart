import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle notoSerif32whiteW600 = TextStyle(
    // fontFamily: 'Noto Serif',
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );
  static final TextStyle plusJakartaSans12whiteW600 = TextStyle(
    // fontFamily: 'Plus Jakarta Sans',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white.withValues(alpha: 0.7),
    letterSpacing: 1.5,
  );
  static const TextStyle normal32primaryW700 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );
  static const TextStyle normal16primaryW700 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );
  static const TextStyle normal16onSurfaceVariant = TextStyle(
    fontSize: 16,
    color: AppColors.onSurfaceVariant,
  );
  static const TextStyle normal12outlineW600 = TextStyle(
    fontSize: 12,
    color: AppColors.outline,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle normal12onSurfaceW600 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: AppColors.onSurface,
  );
  static const TextStyle normal12W600 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );
  static const TextStyle normal28primaryBold = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
  static const TextStyle normal14onSurfaceVariant = TextStyle(
    fontSize: 14,
    color: AppColors.onSurfaceVariant,
    height: 1.5,
  );
  static const TextStyle normal12onSurfaceVariantW600 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurfaceVariant,
  );
  static const TextStyle normal16primaryW600 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
  static const TextStyle normal32primaryBold = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    letterSpacing: -0.5,
  );
  static const TextStyle normal32primaryContainerW600 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryContainer,
    letterSpacing: -0.5,
  );
  static const TextStyle normal36primaryContainerW700 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryContainer,
    height: 1.2,
  );
  static const TextStyle notoSerif20primaryContainerBold = TextStyle(
    fontFamily: 'NotoSerif',
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: AppColors.primaryContainer,
    letterSpacing: 2,
  );
  static const TextStyle notoSerif24primaryContainerW600 = TextStyle(
    fontFamily: 'NotoSerif',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryContainer,
  );
  static const TextStyle normal12primaryContainerBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryContainer,
  );
  static const TextStyle normal12dangerRedW600 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1,
    letterSpacing: 0.05 * 12,
    color: AppColors.dangerRed,
  );
  static const TextStyle normal14onSurfaceW400 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.onSurface,
  );
  static const TextStyle normal14onSurfaceVariantW400 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.onSurfaceVariant,
  );
  static const TextStyle normal28primaryContainerW700 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.02 * 28,
    height: 1.2,
    color: AppColors.primaryContainer,
  );
  static const TextStyle notoSerif40onSurfaceW700 = TextStyle(
    fontFamily: 'Noto Serif',
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    height: 1.2,
    letterSpacing: -0.02,
  );

  static const TextStyle notoSerif24onSurfaceW600 = TextStyle(
    fontFamily: 'Noto Serif',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    height: 1.4,
  );

  static const TextStyle normal18onSurfaceVariantW400 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
    height: 1.6,
  );

  static const TextStyle normal16onSurfaceW400 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
    height: 1.6,
  );

  static const TextStyle normal16onSurfaceW500 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
    height: 1.6,
  );

  static const TextStyle normal14onSurfaceW500 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
    height: 1.4,
  );

  static const TextStyle normal16whiteW400 = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );

  static const TextStyle normal16onSecondaryFixedW400 = TextStyle(
    fontSize: 16,
    color: AppColors.onSecondaryFixed,
  );

  static const TextStyle normal12onSecondaryFixedW600 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.onSecondaryFixed,
  );

  static const TextStyle normal12onSurfaceVariantW500 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurfaceVariant,
  );
}
