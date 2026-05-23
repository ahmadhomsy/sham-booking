import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle notoSerif32whiteW600 = const TextStyle(
    fontFamily: 'Noto Serif',
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );
  static TextStyle plusJakartaSans12whiteW600 = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white.withOpacity(0.7),
    letterSpacing: 1.5,
  );
}
