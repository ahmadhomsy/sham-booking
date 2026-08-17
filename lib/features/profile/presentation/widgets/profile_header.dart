import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_decorations.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.email, required this.name, super.key});
  final String name;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: AppTextStyles.normal28primaryContainerW700,
          textAlign: TextAlign.center,
        ),
        8.verticalSpace,
        Container(
          decoration: AppDecorations.profileHeaderDecoration,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FaIcon(
                FontAwesomeIcons.envelope,
                color: AppColors.goldAccent,
                size: 16,
              ),
              6.horizontalSpace,
              Text(
                email,
                style: AppTextStyles.normal12dangerRedW600.copyWith(
                  color: AppColors.goldAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
