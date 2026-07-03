import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class GlassEmailCard extends StatelessWidget {
  const GlassEmailCard({super.key});

  @override
  Widget build(BuildContext context) {
    final email = box.read<String>(emailKey) ?? 'user.name@example.com';
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.mail,
                color: AppColors.secondary,
                size: 20,
              ),
              12.horizontalSpace,
              Text(
                email,
                style: AppTextStyles.normal16primaryW600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
