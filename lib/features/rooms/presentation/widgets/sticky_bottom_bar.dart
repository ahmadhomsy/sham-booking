import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class AppTypography {
  static final TextStyle h1 = GoogleFonts.notoSerif(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.8,
  );
  static final TextStyle h2 = GoogleFonts.notoSerif(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  static final TextStyle h3 = GoogleFonts.notoSerif(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  static final TextStyle bodyLg = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );
  static final TextStyle bodyMd = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );
  static final TextStyle labelSm = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1,
    letterSpacing: 0.6, // 0.05em
  );
}

class StickyBottomBar extends StatelessWidget {
  const StickyBottomBar({
    required this.price,
    required this.onTap, // قمنا بإضافة هذا السطر
    super.key,
  });
  final String price;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.backgroundStart,
        border: Border(
          top: BorderSide(
            color: AppColors.primaryContainer.withValues(alpha: 0.1),
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(15, 32, 64, 0.08),
            blurRadius: 30,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'booking.price_per_night'.tr(),
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              Text(
                '\$$price',
                style: AppTypography.h2.copyWith(
                  color: AppColors.primaryContainer,
                ),
              ),
              Text(
                'booking.taxes_included'.tr(),
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.outline,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryContainer,
              foregroundColor: AppColors.surfaceContainerLowest,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              elevation: 8,
              textStyle: AppTypography.labelSm.copyWith(letterSpacing: 2),
            ),
            child: Text('booking.book_now'.tr()),
          ),
        ],
      ),
    );
  }
}
