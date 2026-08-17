import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(
        color: AppColors.primaryContainer.withValues(alpha: 0.1),
        thickness: 1,
      ),
    );
  }
}
