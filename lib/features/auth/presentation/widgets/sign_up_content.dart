import 'package:easy_localization/easy_localization.dart';
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
        Text(
          'auth.create_account'.tr(),
          style: AppTextStyles.normal28primaryBold,
        ),
        8.verticalSpace,
        Text(
          'auth.sign_up_description'.tr(),
          style: AppTextStyles.normal14onSurfaceVariant,
        ),
        32.verticalSpace,
        const SignUpForm(),

        24.verticalSpace,
        const DividerAuth(),
        24.verticalSpace,
        const SignLink(
          title1: 'auth.already_have_account',
          title2: 'auth.sign_in',
          addressPage: 'signIn',
        ),
      ],
    );
  }
}
