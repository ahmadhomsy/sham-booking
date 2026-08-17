import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_decorations.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';
import 'package:sham_booking/features/home/presentation/widgets/custom_hotel_image.dart';

class MapHotelSummaryCard extends StatelessWidget {
  const MapHotelSummaryCard({
    required this.hotel,
    super.key,
  });

  final HotelModel hotel;

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        hotel.mainImg ?? ((hotel.images.isNotEmpty) ? hotel.images.first : '');

    final discountValue = double.tryParse(hotel.discount ?? '0') ?? 0;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppDecorations.mapHotelSummaryCardDecoration,
      child: Row(
        children: [
          CustomHotelImage(
            imageUrl: imageUrl,
            width: 80,
            height: 80,
            borderRadius: 12,
          ),

          12.horizontalSpace,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  hotel.name,
                  style: AppTextStyles.normal12W600.copyWith(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                4.verticalSpace,

                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidStar,
                      size: 12,
                      color: AppColors.secondaryContainer,
                    ),
                    4.horizontalSpace,
                    Text(
                      hotel.rating,
                      style: AppTextStyles.normal12W600,
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: Text(
                        hotel.city?.name ?? '',
                        style: AppTextStyles.normal12W600.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,

                if (discountValue > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.dangerRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${hotel.discount}% OFF',
                      style: const TextStyle(
                        color: AppColors.surfaceContainerLowest,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  Text(
                    hotel.address,
                    style: AppTextStyles.normal12W600.copyWith(
                      color: AppColors.primaryContainer,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),

          IconButton.filledTonal(
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primaryContainer,
              foregroundColor: AppColors.secondaryContainer,
              overlayColor: AppColors.goldAccent,
            ),
            onPressed: () async {
              await context.pushNamed(
                'hotelDetails',
                pathParameters: {
                  'id': hotel.id.toString(),
                },
              );
            },
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ],
      ),
    );
  }
}
