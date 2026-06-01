import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingBackgroundAndText extends StatelessWidget {
  const OnboardingBackgroundAndText({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });
  final String image;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.95),
                  Colors.black.withValues(alpha: 0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 24, right: 24, bottom: 130.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                      title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                    .animate() // 2. بدء الأنيميشن للعنوان
                    .fade(duration: 600.ms) // ظهور تدريجي
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOutQuad,
                    ),
                12.verticalSpace,
                Text(
                      desc,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.8),
                        height: 1.5,
                      ),
                    )
                    .animate() // 3. أنيميشن الوصف
                    .fade(
                      duration: 600.ms,
                      delay: 200.ms,
                    ) // نؤخره قليلاً (200ms) ليظهر بعد العنوان
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      duration: 600.ms,
                      delay: 200.ms,
                      curve: Curves.easeOutQuad,
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
