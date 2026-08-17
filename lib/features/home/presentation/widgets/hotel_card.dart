import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/helpers/launcher_service.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_decorations.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';
import 'package:sham_booking/features/home/presentation/widgets/contact_chip.dart';
import 'package:sham_booking/features/home/presentation/widgets/custom_hotel_image.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({
    required this.hotel,
    super.key,
  });
  final HotelModel hotel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.hotelCardDecoration,
      clipBehavior: Clip.antiAlias,

      child: GestureDetector(
        onTap: () async {
          await context.pushNamed(
            'hotelDetails',
            pathParameters: {
              'id': hotel.id.toString(),
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomHotelImage(
                  imageUrl:
                      hotel.mainImg ??
                      (hotel.images.isNotEmpty ? hotel.images.first : null),
                  borderRadius: 12,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 80,
                  child: Container(
                    decoration: AppDecorations.gradientOverlay,
                  ),
                ),

                if (hotel.discount != null &&
                    (double.tryParse(hotel.discount ?? '0') ?? 0) > 0)
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.dangerRed,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Text(
                        'home.explore.discount'.tr(
                          args: [hotel.discount!],
                        ),
                        style: const TextStyle(
                          color: AppColors.surfaceContainerLowest,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest.withValues(
                        alpha: 0.9,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.secondaryContainer,
                          size: 16,
                        ),
                        4.horizontalSpace,
                        Text(
                          hotel.rating,
                          style: AppTextStyles.normal12primaryContainerBold,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: AppTextStyles.notoSerif24primaryContainerW600,
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppColors.onSurfaceVariant,
                      ),
                      4.horizontalSpace,
                      Expanded(
                        child: Text(
                          [
                                hotel.city?.name,
                                hotel.address,
                              ]
                              .where(
                                (value) => value != null && value.isNotEmpty,
                              )
                              .join(' - '),
                          style: AppTextStyles.normal14onSurfaceVariant
                              .copyWith(
                                height: 0,
                              ),
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  if (hotel.description != null &&
                      hotel.description!.isNotEmpty)
                    Text(
                      hotel.description!,
                      style: AppTextStyles.normal14onSurfaceVariant,
                    ),
                  16.verticalSpace,
                  const Divider(height: 1, color: AppColors.outlineVariant),
                  16.verticalSpace,
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      if (hotel.phone != null && hotel.phone!.isNotEmpty)
                        ContactChip(
                          icon: const FaIcon(
                            FontAwesomeIcons.phone,
                            size: 14,
                            color: AppColors.primaryContainer,
                          ),
                          label: hotel.phone!,
                          onTap: () async {
                            await LauncherService.openPhone(hotel.phone!);
                          },
                        ),
                      if (hotel.website != null && hotel.website!.isNotEmpty)
                        ContactChip(
                          icon: const FaIcon(
                            FontAwesomeIcons.globe,
                            size: 14,
                            color: AppColors.primaryContainer,
                          ),
                          label: 'Website',
                          onTap: () async {
                            await LauncherService.openUrl(hotel.website!);
                          },
                        ),
                      if (hotel.facebook != null && hotel.facebook!.isNotEmpty)
                        ContactChip(
                          icon: const FaIcon(
                            FontAwesomeIcons.facebook,
                            size: 14,
                            color: AppColors.primaryContainer,
                          ),
                          label: 'Facebook',
                          onTap: () async {
                            await LauncherService.openUrl(hotel.facebook!);
                          },
                        ),

                      if (hotel.instagram != null &&
                          hotel.instagram!.isNotEmpty)
                        ContactChip(
                          icon: const FaIcon(
                            FontAwesomeIcons.instagram,
                            size: 14,
                            color: AppColors.primaryContainer,
                          ),
                          label: 'Instagram',
                          onTap: () async {
                            await LauncherService.openUrl(hotel.instagram!);
                          },
                        ),
                      if (hotel.email != null && hotel.email!.isNotEmpty)
                        ContactChip(
                          icon: const FaIcon(
                            FontAwesomeIcons.envelope,
                            size: 14,
                            color: AppColors.primaryContainer,
                          ),
                          label: hotel.email!,
                          onTap: () async {
                            await LauncherService.openEmail({
                              'email': hotel.email!,
                            });
                          },
                        ),
                    ],
                  ),
                  24.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
