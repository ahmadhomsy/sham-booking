import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/logos/app_logo.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            32.verticalSpace,
            const Text(
              'ShamBook',
              style: AppTextStyles.notoSerif32whiteW600,
            ),
            8.verticalSpace,
            Text(
              'MODERN LEVANTINE LUXURY',
              style: AppTextStyles.plusJakartaSans12whiteW600,
            ),
          ],
        )
        .animate() // 3. أنيميشن الوصف
        .fade(
          duration: 800.ms,
          delay: 200.ms,
        );
  }
}
