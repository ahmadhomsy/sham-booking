import 'package:flutter/material.dart';

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
}
