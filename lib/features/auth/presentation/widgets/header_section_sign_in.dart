import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class HeaderSectionSignIn extends StatelessWidget {
  const HeaderSectionSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            image: const DecorationImage(
              image: AssetImage(
                'assets/logos/app_logo.webp',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        16.verticalSpace,
        Text(
          'auth.welcome_back'.tr(),
          style: AppTextStyles.normal32primaryW700,
        ),
        8.verticalSpace,
        Text(
          'auth.sign_in_description'.tr(),
          style: AppTextStyles.normal16onSurfaceVariant,
        ),
      ],
    );
  }
}
