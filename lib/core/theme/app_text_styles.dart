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
}
