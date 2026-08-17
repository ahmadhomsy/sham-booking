import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class BottomControls extends StatelessWidget {
  const BottomControls({
    required this.currentPage,
    required this.onNext,
    super.key,
  });
  final int currentPage;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // لتأخذ أقل مساحة ممكنة في الأسفل
      children: [
        // النقاط (Indicators)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            onBoardingList.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: currentPage == index ? 24.w : 10.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? AppColors.secondaryContainer
                    : AppColors.backgroundStart,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        20.verticalSpace,
        // زر التالي
        SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: onNext,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'onboarding.next'.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    8.horizontalSpace,
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black87,
                      size: 18,
                    ),
                  ],
                ),
              ),
            )
            .animate()
            .fade(duration: 600.ms, delay: 400.ms) // يظهر أخيراً بعد النصوص
            .scaleXY(
              begin: 0.9,
              end: 1,
              duration: 600.ms,
              delay: 400.ms,
              curve: Curves.easeOutBack,
            ),
      ],
    );
  }
}
