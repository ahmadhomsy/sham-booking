import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';
import 'package:sham_booking/features/hotel/presentation/bloc/hotel_details_bloc.dart';
import 'package:sham_booking/features/hotel/presentation/widgets/custom_divider.dart';
import 'package:sham_booking/features/hotel/presentation/widgets/hero_section.dart';
import 'package:sham_booking/features/hotel/presentation/widgets/hotel_contact_section.dart';
import 'package:sham_booking/features/hotel/presentation/widgets/hotel_gallery_section.dart';
import 'package:sham_booking/features/hotel/presentation/widgets/map_snippet_section.dart';
import 'package:sham_booking/features/hotel/presentation/widgets/room_selection_section.dart';

class AppTypography {
  static final TextStyle h2 = GoogleFonts.notoSerif(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.primaryContainer,
  );

  static final TextStyle bodyMd = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.onSurfaceVariant,
  );

  static final TextStyle labelSm = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.6,
  );
}

class HotelDetailsPage extends StatelessWidget {
  const HotelDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelDetailsBloc, HotelDetailsState>(
      builder: (context, state) {
        final hotel = state.hotel;

        final isLoading =
            state.hotelStatus == HotelDetailsStatus.loading && hotel == null;

        if (state.hotelStatus == HotelDetailsStatus.failure && hotel == null) {
          return Scaffold(
            backgroundColor: AppColors.backgroundStart,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.hotelErrorMessage ??
                      'hotel_details.something_went_wrong'.tr(),
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMd,
                ),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.backgroundStart,
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeroSection(
                      imageUrl:
                          hotel?.mainImg ??
                          (hotel != null && hotel.images.isNotEmpty
                              ? hotel.images.first
                              : null),
                      title: hotel?.name ?? 'hotel_details.loading_hotel'.tr(),
                      location:
                          hotel?.address ??
                          'hotel_details.loading_location'.tr(),
                      rating: hotel?.rating,
                      isLoading: isLoading,
                      errorMessage: state.hotelErrorMessage,
                    ),

                    if (hotel != null) ...[
                      const SizedBox(height: 24),

                      _HotelQuickInfo(hotel: hotel),

                      const SizedBox(height: 32),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SectionTitle(
                              icon: Icons.hotel_outlined,
                              title: 'hotel_details.about_hotel'.tr(),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              hotel.description?.isNotEmpty == true
                                  ? hotel.description!
                                  : 'hotel_details.no_description'.tr(),
                              style: AppTypography.bodyMd,
                            ),

                            const SizedBox(height: 28),

                            HotelGallerySection(
                              images: hotel.images,
                            ),

                            const SizedBox(height: 32),

                            HotelContactSection(
                              phone: hotel.phone,
                              email: hotel.email,
                              website: hotel.website,
                              facebook: hotel.facebook,
                              instagram: hotel.instagram,
                            ),

                            const SizedBox(height: 32),

                            _SectionTitle(
                              icon: Icons.location_on_outlined,
                              title: 'hotel_details.location'.tr(),
                            ),

                            const SizedBox(height: 16),

                            MapSnippetSection(
                              address: hotel.address,
                              latitude: double.tryParse(
                                hotel.mapLatitude ?? '',
                              ),
                              longitude: double.tryParse(
                                hotel.mapLongitude ?? '',
                              ),
                              hotelName: hotel.name,
                            ),

                            const SizedBox(height: 32),

                            const CustomDivider(),

                            const SizedBox(height: 28),

                            RoomSelectionSection(
                              selectedFilter: state.selectedFilter,
                              onFilterChanged: (filter) {
                                context.read<HotelDetailsBloc>().add(
                                  HotelDetailsRoomsFilterChanged(filter),
                                );
                              },
                              isLoading:
                                  state.roomsStatus ==
                                  HotelDetailsStatus.loading,
                              errorMessage: state.roomsErrorMessage,
                              allRooms: state.rooms,
                              availableRooms: state.availableRooms,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Bottom action
            ],
          ),
        );
      },
    );
  }
}

class _HotelQuickInfo extends StatelessWidget {
  const _HotelQuickInfo({
    required this.hotel,
  });

  final HotelModel hotel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: _QuickInfoItem(
              icon: Icons.star_rounded,
              value: hotel.rating,
              label: 'hotel_details.rating'.tr(),
              iconColor: AppColors.secondaryContainer,
            ),
          ),
          Expanded(
            child: _QuickInfoItem(
              icon: Icons.location_on_outlined,
              value: 'hotel_details.damascus'.tr(),
              label: 'hotel_details.location'.tr(),
              iconColor: AppColors.goldAccent,
            ),
          ),
          Expanded(
            child: _QuickInfoItem(
              icon: Icons.local_offer_outlined,
              value: hotel.discount != null ? '${hotel.discount}%' : '—',
              label: 'hotel_details.discount'.tr(),
              iconColor: AppColors.secondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickInfoItem extends StatelessWidget {
  const _QuickInfoItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryContainer,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.secondaryContainer.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.secondary,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: AppTypography.h2.copyWith(
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
