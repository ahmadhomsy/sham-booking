import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/features/auth/presentation/widgets/header_background_sign_up.dart';
import 'package:sham_booking/features/auth/presentation/widgets/sign_up_content.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundStart,
      body: Stack(
        children: [
          const HeaderBackgroundSignUp(),
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 40,
              ),
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest.withValues(
                    alpha: 0.95,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      blurRadius: 40,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(
                    color: AppColors.outlineVariant.withValues(alpha: 0.3),
                  ),
                ),
                child: const SignUpContent(),
              ),
            ),
          ),
          // const _TopBar(),
        ],
      ),
    );
  }
}
