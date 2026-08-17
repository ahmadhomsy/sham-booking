import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class HelpCenterHeader extends StatelessWidget {
  const HelpCenterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(50),
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Column(
            children: [
              Text(
                'help_center.title'.tr(),
                style: AppTextStyles.notoSerif40onSurfaceW700,
              ),
              const SizedBox(height: 8),
              Text(
                'help_center.subtitle'.tr(),
                style: AppTextStyles.normal18onSurfaceVariantW400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
