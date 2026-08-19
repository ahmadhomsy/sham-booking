import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';
import 'package:sham_booking/features/home/presentation/widgets/custom_hotel_image.dart';
import 'package:sham_booking/features/rooms/data/models/show_room_response.dart';
import 'package:sham_booking/features/rooms/presentation/bloc/show_room_bloc.dart';
import 'package:sham_booking/features/rooms/presentation/widgets/room_features_grid.dart';
import 'package:sham_booking/features/rooms/presentation/widgets/room_gallery_section.dart';
import 'package:sham_booking/features/rooms/presentation/widgets/room_hero_section.dart';
import 'package:sham_booking/features/rooms/presentation/widgets/sticky_bottom_bar.dart';

class RoomDetailsPage extends StatefulWidget {
  const RoomDetailsPage({super.key});

  @override
  State<RoomDetailsPage> createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  @override
  void initState() {
    super.initState();

    context.read<ShowRoomBloc>().add(
      const ShowRoomStarted(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowRoomBloc, ShowRoomState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const _RoomLoadingView();
        }

        if (state.isFailure) {
          return _RoomErrorView(
            message: state.errorMessage,
          );
        }

        final room = state.room;

        if (room == null) {
          return _RoomErrorView(
            message: 'room_details.room_information_unavailable'.tr(),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.backgroundStart,

          bottomNavigationBar: StickyBottomBar(
            price: room.type.basePrice,
            onTap: () async {
              // هنا ننتقل لصفحة الحجز ونمرر الـ IDs المطلوبة
              await context.pushNamed(
                'createBooking',
                pathParameters: {
                  'hotelId': room.hotel.id.toString(),
                  'roomId': room.id.toString(),
                },
              );
            },
          ),

          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              RoomHeroSection(
                imageUrl: room.type.images.isNotEmpty
                    ? room.type.images.first
                    : 'assets/images/room_placeholder.jpg',
                roomName: room.type.name,
                isLoading: false,
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    24,
                    24,
                    24,
                    120,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _RoomHeader(
                        room: room,
                      ),

                      const SizedBox(height: 32),

                      _RoomStatus(
                        status: room.status,
                      ),

                      const SizedBox(height: 32),

                      _SectionTitle(
                        icon: Icons.auto_awesome,
                        title: 'room_details.room_amenities'.tr(),
                      ),

                      const SizedBox(height: 16),

                      RoomFeaturesGrid(
                        features: _mapRoomFeatures(
                          room.type.amenities,
                        ),
                      ),

                      const SizedBox(height: 36),

                      _RoomDescription(
                        room: room,
                      ),

                      const SizedBox(height: 36),
                      if (room.bookings.isNotEmpty) ...[
                        _BookingsSection(
                          bookings: room.bookings,
                        ),
                        const SizedBox(height: 36),
                      ],
                      if (room.type.images.length > 1) ...[
                        _SectionTitle(
                          icon: Icons.photo_library_outlined,
                          title: 'room_details.room_gallery'.tr(),
                        ),

                        const SizedBox(height: 16),

                        RoomGallerySection(
                          images: room.type.images,
                          heroTag: 'room_${room.id}',
                        ),

                        const SizedBox(height: 36),
                      ],

                      _HotelInformation(
                        hotel: room.hotel,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> _mapRoomFeatures(
    List<String> amenities,
  ) {
    final amenityIcons = <String, IconData>{
      'wifi': Icons.wifi_rounded,
      'ac': Icons.ac_unit_rounded,
      'tv': Icons.tv_rounded,
      'bathroom': Icons.bathtub_outlined,
      'bed': Icons.bed_rounded,
      'fridge': Icons.kitchen_rounded,
      'microwave': Icons.microwave_rounded,
      'parking': Icons.local_parking_rounded,
      'pet': Icons.pets_rounded,
      'pool': Icons.pool_rounded,
    };

    return amenities.map((amenity) {
      final key = amenity.toLowerCase().trim();

      return {
        'icon': amenityIcons[key] ?? Icons.check_circle_outline_rounded,
        'title': amenity,
      };
    }).toList();
  }
}

class _RoomHeader extends StatelessWidget {
  const _RoomHeader({
    required this.room,
  });

  final RoomData room;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                room.type.name,
                style: GoogleFonts.notoSerif(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryContainer,
                  height: 1.2,
                ),
              ),
            ),

            const SizedBox(width: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  room.type.basePrice,
                  style: GoogleFonts.notoSerif(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryContainer,
                  ),
                ),
                Text(
                  'room_details.per_night'.tr(),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 14),

        Row(
          children: [
            const Icon(
              Icons.hotel_outlined,
              size: 18,
              color: AppColors.goldAccent,
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                room.hotel.name,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 18,
              color: AppColors.goldAccent,
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                room.hotel.address,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RoomStatus extends StatelessWidget {
  const _RoomStatus({
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final isAvailable = status.toLowerCase() == 'available';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: isAvailable
            ? AppColors.secondaryContainer.withValues(alpha: .18)
            : AppColors.dangerRed.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isAvailable
              ? AppColors.secondaryContainer
              : AppColors.dangerRed.withValues(alpha: .3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            size: 10,
            color: isAvailable ? AppColors.secondary : AppColors.dangerRed,
          ),

          const SizedBox(width: 8),

          Text(
            isAvailable ? 'room_details.available'.tr() : status,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isAvailable ? AppColors.secondary : AppColors.dangerRed,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomDescription extends StatelessWidget {
  const _RoomDescription({
    required this.room,
  });

  final RoomData room;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(
          icon: Icons.description_outlined,
          title: 'room_details.about_this_room'.tr(),
        ),

        const SizedBox(height: 14),

        Text(
          'room_details.room_description'.tr(
            namedArgs: {
              'room_name': room.type.name,
              'room_number': room.roomNumber,
            },
          ),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            height: 1.7,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
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
            color: AppColors.secondaryContainer.withValues(alpha: .18),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.secondary,
          ),
        ),

        const SizedBox(width: 12),

        Text(
          title,
          style: GoogleFonts.notoSerif(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryContainer,
          ),
        ),
      ],
    );
  }
}

class _HotelInformation extends StatelessWidget {
  const _HotelInformation({
    required this.hotel,
  });

  final HotelModel hotel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: .45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.hotel_outlined,
            title: 'room_details.your_hotel'.tr(),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: hotel.logoImg != null
                      ? CustomHotelImage(
                          imageUrl: hotel.logoImg!,
                        )
                      : const ColoredBox(
                          color: AppColors.backgroundEnd,
                          child: Icon(
                            Icons.hotel,
                            color: AppColors.primaryContainer,
                          ),
                        ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel.name,
                      style: GoogleFonts.notoSerif(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryContainer,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      hotel.address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Divider(
            color: AppColors.outlineVariant,
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                color: AppColors.secondaryContainer,
              ),

              const SizedBox(width: 6),

              Text(
                hotel.rating,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryContainer,
                ),
              ),

              const Spacer(),

              Text(
                '${'room_details.room'.tr()} ${hotel.name}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoomLoadingView extends StatelessWidget {
  const _RoomLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundStart,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.secondaryContainer,
        ),
      ),
    );
  }
}

class _RoomErrorView extends StatelessWidget {
  const _RoomErrorView({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundStart,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.hotel_outlined,
                size: 60,
                color: AppColors.dangerRed,
              ),

              const SizedBox(height: 20),

              Text(
                'room_details.unable_to_load_room'.tr(),
                style: GoogleFonts.notoSerif(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryContainer,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookingsSection extends StatelessWidget {
  const _BookingsSection({required this.bookings});

  final List<dynamic>
  bookings; // تأكد من استبدال dynamic بنوع الـ Model الخاص بالحجز لديك

  @override
  Widget build(BuildContext context) {
    final activeBookings = bookings
        .where((b) => b.status.toString().toLowerCase() != 'cancelled')
        .toList();

    if (activeBookings.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(
          icon: Icons.calendar_today_rounded,
          title: 'room_details.upcoming_bookings'.tr(),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: activeBookings.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final booking = activeBookings[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.outlineVariant.withValues(alpha: .3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.event_available, color: AppColors.secondary),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${booking.checkIn} ${'room_details.to'.tr()} ${booking.checkOut}',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryContainer,
                        ),
                      ),
                      Text(
                        '${'room_details.guest'.tr()}: ${booking.guestName}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
