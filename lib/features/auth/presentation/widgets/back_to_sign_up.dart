import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class BackToSignUp extends StatelessWidget {
  const BackToSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.go('/signUp');
      },
      style: TextButton.styleFrom(
        foregroundColor: AppColors.onSurfaceVariant,
        textStyle: AppTextStyles.normal12W600.copyWith(
          letterSpacing: 0.5,
        ),
      ),
      child: const Text(
        'Back to Sign Up',
        style: TextStyle(decoration: TextDecoration.underline),
      ),
    );
  }
}
