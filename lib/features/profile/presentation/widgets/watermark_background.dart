import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class WatermarkBackground extends StatelessWidget {
  const WatermarkBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -20,
      right: 0,
      left: 0,
      child: Center(
        child: Text(
          'S',
          style: TextStyle(
            fontFamily: 'Noto Serif',
            fontSize: 250,
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.03),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
