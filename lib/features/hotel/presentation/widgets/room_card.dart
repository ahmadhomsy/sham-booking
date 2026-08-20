import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/features/hotel/presentation/widgets/custom_room_image.dart';

class AppTypography {
  static final TextStyle h3 = GoogleFonts.notoSerif(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.4,
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
    letterSpacing: 0.6,
  );
}

class RoomCard extends StatelessWidget {
  const RoomCard({
    required this.id,
    required this.title,
    required this.price,
    required this.imgUrl,
    required this.features,
    super.key,
  });

  final String title;
  final String price;
  final String imgUrl;
  final int id;
  final List<String> features;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(15, 32, 64, 0.04),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRoomImage(
            imageUrl: imgUrl,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTypography.h3.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          price,
                          style: AppTypography.h3.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          '/ night',
                          style: AppTypography.bodyMd.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: features
                      .map(
                        (feature) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                size: 14,
                                color: AppColors.onSurfaceVariant,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                feature,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {
                      await context.pushNamed(
                        'roomDetails',
                        pathParameters: {
                          'id': id.toString(),
                        },
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryContainer,
                      side: const BorderSide(color: AppColors.primaryContainer),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      textStyle: AppTypography.labelSm,
                    ),
                    child: Text('booking.show_room'.tr()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
