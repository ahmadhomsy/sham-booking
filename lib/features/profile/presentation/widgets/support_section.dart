import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_shadow.dart';
import 'package:sham_booking/features/profile/presentation/widgets/section_title.dart';
import 'package:sham_booking/features/profile/presentation/widgets/support_list_item.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'home.profile.support.title'.tr(),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [AppShadow.cardShadow],
          ),
          child: Column(
            children: [
              SupportListItem(
                icon: Icons.help,
                label: 'home.profile.support.help_center'.tr(),
                iconColor: Colors.grey,
                textColor: AppColors.onSurface,
                onTap: () async {
                  await context.pushNamed(
                    'helpCenter',
                  );
                },
              ),
              const Divider(indent: 16, height: 1),
              SupportListItem(
                icon: Icons.support_agent,
                label: 'home.profile.support.contact_ai_concierge'.tr(),
                iconColor: AppColors.goldAccent,
                textColor: AppColors.primaryContainer,
                isBold: true,
                onTap: () async {
                  await context.pushNamed(
                    'contactAiConcierge',
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
