import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sham_booking/core/helpers/launcher_service.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelContactSection extends StatelessWidget {
  const HotelContactSection({
    this.phone,
    this.email,
    this.website,
    this.facebook,
    this.instagram,
    super.key,
  });

  final String? phone;
  final String? email;
  final String? website;
  final String? facebook;
  final String? instagram;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];

    if (phone != null && phone!.isNotEmpty) {
      items.add(
        _ContactItem(
          icon: Icons.phone_outlined,
          title: 'Phone',
          value: phone!,
          onTap: () async {
            await LauncherService.openPhone(phone!);
          },
        ),
      );
    }

    if (email != null && email!.isNotEmpty) {
      items.add(
        _ContactItem(
          icon: Icons.email_outlined,
          title: 'Email',
          value: email!,
          onTap: () async {
            await LauncherService.openEmail({
              'email': email!,
            });
          },
        ),
      );
    }

    if (website != null && website!.isNotEmpty) {
      items.add(
        _ContactItem(
          icon: Icons.language,
          title: 'Website',
          value: website!,
          onTap: () async {
            await LauncherService.openUrl(website!);
          },
        ),
      );
    }

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact & Information',
          style: GoogleFonts.notoSerif(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryContainer,
          ),
        ),
        const SizedBox(height: 16),

        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer.withValues(
                  alpha: 0.06,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryContainer,
                size: 22,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryContainer,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppColors.outline,
            ),
          ],
        ),
      ),
    );
  }
}
