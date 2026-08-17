import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/profile/presentation/widgets/help_center_header.dart';
import 'package:sham_booking/features/profile/presentation/widgets/popular_questions_list.dart';
import 'package:sham_booking/features/profile/presentation/widgets/quick_categories_grid.dart';
import 'package:sham_booking/features/profile/presentation/widgets/still_need_help_section.dart';
import 'package:sham_booking/features/profile/presentation/widgets/watermark_background.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundStart,
      body: SafeArea(
        child: Stack(
          children: [
            const WatermarkBackground(),
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const HelpCenterHeader(),
                        const SizedBox(height: 48),
                        Center(
                          child: Text(
                            'help_center.quick_categories'.tr(),
                            style: AppTextStyles.notoSerif24onSurfaceW600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const QuickCategoriesGrid(),
                        const SizedBox(height: 48),
                        Center(
                          child: Text(
                            'faq.popular_questions'.tr(),
                            style: AppTextStyles.notoSerif24onSurfaceW600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const PopularQuestionsList(),
                        const SizedBox(height: 48),
                        const StillNeedHelpSection(),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
