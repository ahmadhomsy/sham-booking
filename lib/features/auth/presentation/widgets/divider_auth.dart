import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class DividerAuth extends StatelessWidget {
  const DividerAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR CONTINUE WITH',
            style: AppTextStyles.normal12outlineW600,
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
