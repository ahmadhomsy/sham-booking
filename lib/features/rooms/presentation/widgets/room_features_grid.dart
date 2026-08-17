import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class RoomFeaturesGrid extends StatelessWidget {
  const RoomFeaturesGrid({
    required this.features,
    super.key,
  });

  final List<Map<String, dynamic>> features;

  @override
  Widget build(BuildContext context) {
    if (features.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'room_details.room_features'.tr(),
          style: AppTextStyles.normal28primaryBold,
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisExtent: 120,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: features
              .map(
                (feature) => FeatureItem(
                  icon: (feature['icon'] as IconData?) ?? Icons.check_circle,
                  title: (feature['title'] as String?) ?? 'Feature',
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class FeatureItem extends StatelessWidget {
  const FeatureItem({
    required this.icon,
    required this.title,
    super.key,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: AppColors.primary,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.normal12onSurfaceVariantW600,
          ),
        ],
      ),
    );
  }
}
