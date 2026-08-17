import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class HeaderBackgroundSignUp extends StatelessWidget {
  const HeaderBackgroundSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/logos/app_logo.webp', fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary.withValues(alpha: 0.4),
                  AppColors.primary.withValues(alpha: 0.8),
                  AppColors.backgroundStart,
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),
          Positioned(
            left: 24,
            bottom: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ShamBook',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'auth.seamless_hospitality'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
