import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class HeroSearchSection extends StatelessWidget {
  const HeroSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'home.explore.discover_levantine_luxury'.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyles.normal36primaryContainerW700,
        ),
        8.verticalSpace,
        Text(
          'home.explore.find_perfect_sanctuary'.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyles.normal16onSurfaceVariant.copyWith(height: 1.5),
        ),
        15.verticalSpace,
        // Container(
        //   decoration: BoxDecoration(
        //     color: AppColors.surfaceContainerLowest,
        //     borderRadius: BorderRadius.circular(30),
        //     border: Border.all(
        //       color: AppColors.outlineVariant.withValues(alpha: 0.5),
        //     ),
        //     boxShadow: [
        //       BoxShadow(
        //         color: AppColors.primaryContainer.withValues(alpha: 0.04),
        //         blurRadius: 20,
        //         offset: const Offset(0, 4),
        //       ),
        //     ],
        //   ),
        //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        //   child: Row(
        //     children: [
        //       12.horizontalSpace,
        //       Icon(Icons.search, color: Colors.grey.shade500),
        //       12.horizontalSpace,
        //       Expanded(
        //         child: TextField(
        //           decoration: InputDecoration(
        //             hintText: 'home.explore.where_would_you_like_to_stay'.tr(),
        //             hintStyle: TextStyle(
        //               color: Colors.grey.shade400,
        //               fontSize: 16,
        //             ),
        //             border: InputBorder.none,
        //             isDense: true,
        //           ),
        //         ),
        //       ),
        //       Container(
        //         decoration: const BoxDecoration(
        //           color: AppColors.secondaryContainer,
        //           shape: BoxShape.circle,
        //         ),
        //         child: IconButton(
        //           icon: const Icon(
        //             Icons.mic,
        //             color: AppColors.secondary,
        //             size: 20,
        //           ),
        //           onPressed: () {},
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
