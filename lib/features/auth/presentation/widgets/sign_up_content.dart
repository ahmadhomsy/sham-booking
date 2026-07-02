import 'package:flutter/material.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/auth/presentation/widgets/divider_auth.dart';
import 'package:sham_booking/features/auth/presentation/widgets/sign_link.dart';
import 'package:sham_booking/features/auth/presentation/widgets/sign_up_form.dart';

class SignUpContent extends StatelessWidget {
  const SignUpContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Create Account',
          style: AppTextStyles.normal28primaryBold,
        ),
        8.verticalSpace,
        const Text(
          'Join ShamBook to unlock exclusive reservations and personalized concierge services.',
          style: AppTextStyles.normal14onSurfaceVariant,
        ),
        32.verticalSpace,
        const SignUpForm(),

        24.verticalSpace,
        const DividerAuth(),
        24.verticalSpace,
        const SignLink(
          title1: 'Already have an account? ',
          title2: 'Sign In',
          addressPage: 'signIn',
        ),
      ],
    );
  }
}
