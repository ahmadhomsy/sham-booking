import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sham_booking/core/theme/app_decorations.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: AppDecorations.containerLogoDecoration,
          child: Center(
            child: Image.asset(
              'assets/logos/app_logo.png',
              width: 60,
            ),
          ),
        ),
        32.verticalSpace,
        Text(
          'ShamBook',
          style: AppTextStyles.notoSerif32whiteW600,
        ),
        8.verticalSpace,
        Text(
          'MODERN LEVANTINE LUXURY',
          style: AppTextStyles.plusJakartaSans12whiteW600,
        ),
      ],
    );
  }
}
