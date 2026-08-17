import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/helpers/launcher_service.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_decorations.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class StillNeedHelpSection extends StatelessWidget {
  const StillNeedHelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: AppDecorations.needHelpContainerDecoration,
      child: Column(
        children: [
          Text(
            'still_need_help.title'.tr(),
            style: AppTextStyles.notoSerif24onSurfaceW600,
          ),
          const SizedBox(height: 12),
          Text(
            'still_need_help.description'.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.normal16onSurfaceW400.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () async {
                await context.pushNamed(
                  'contactAiConcierge',
                );
              },
              icon: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 20,
              ),
              label: Text(
                'still_need_help.chat_with_ai'.tr(),
                style: AppTextStyles.normal16whiteW400,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // زر طلب مكالمة
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () async {
                await LauncherService.openPhone('+963998501595');
              },
              icon: const Icon(
                Icons.phone_outlined,
                color: AppColors.onSecondaryFixed,
                size: 20,
              ),
              label: Text(
                'still_need_help.request_a_call'.tr(),
                style: AppTextStyles.normal16onSecondaryFixedW400,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryFixed.withValues(
                  alpha: 0.5,
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: AppColors.secondaryFixed,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
