import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/features/hotel/presentation/bloc/hotel_details_bloc.dart';
import 'package:sham_booking/features/hotel/presentation/widgets/room_card.dart';
import 'package:sham_booking/features/rooms/data/models/get_available_room_response.dart';
import 'package:sham_booking/features/rooms/data/models/get_hotel_room_response.dart';

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

class RoomSelectionSection extends StatelessWidget {
  const RoomSelectionSection({
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.isLoading,
    required this.errorMessage,
    required this.allRooms,
    required this.availableRooms,
    super.key,
  });

  final HotelDetailsRoomsFilter selectedFilter;
  final ValueChanged<HotelDetailsRoomsFilter> onFilterChanged;
  final bool isLoading;
  final String? errorMessage;
  final List<HotelRoomModel> allRooms;
  final List<AvailableRoomModel> availableRooms;

  @override
  Widget build(BuildContext context) {
    final rooms = selectedFilter == HotelDetailsRoomsFilter.all
        ? allRooms.map(_buildAllRoomCard).toList()
        : availableRooms.map(_buildAvailableRoomCard).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.bed,
              color: AppColors.secondaryContainer,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'hotel_details.select_your_room'.tr(),
              style: AppTypography.h3.copyWith(
                color: AppColors.primaryContainer,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterPill(
                'hotel_details.all_rooms'.tr(),
                isSelected: selectedFilter == HotelDetailsRoomsFilter.all,
                onTap: () => onFilterChanged(HotelDetailsRoomsFilter.all),
              ),
              // _buildFilterPill(
              //   'Available',
              //   isSelected: selectedFilter == HotelDetailsRoomsFilter.available,
              //   onTap: () => onFilterChanged(HotelDetailsRoomsFilter.available),
              // ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else if (errorMessage != null)
          Text(
            errorMessage!,
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.primaryContainer,
            ),
          )
        else if (rooms.isEmpty)
          Text(
            'No rooms found for this filter.',
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          )
        else
          Column(
            children: rooms
                .map(
                  (room) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: room,
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget _buildAllRoomCard(HotelRoomModel room) {
    return RoomCard(
      id: room.id,
      title: room.name,
      price: room.basePrice,
      imgUrl: room.images.isNotEmpty
          ? room.images.first
          : 'https://lh3.googleusercontent.com/aida-public/AB6AXuDb3RSX6Ngi4Rs7OprYciO4TivMn88JFvJFMoMUboJfSBfU4OAYpuj9gdRgw23hDD1w4Vg0-SxD8nsVNGk7zAYCsIij5sM9zi-0bNVT_U2WZsrlmtlLiL2X8IEe1U05odfhEllXOrHSPXqnUHUb6NigZWGTcZ3wCx9_ClqgTEgFp3lsfYVysIJ1ld5y7ZOz9oZKWYcSdyiJcBRhwIoE_ce9OYPfSeEDgunUY52krm52W2_fIA1izU1a',
      features: room.amenities,
    );
  }

  Widget _buildAvailableRoomCard(AvailableRoomModel room) {
    return RoomCard(
      id: room.id,
      title: room.name,
      price: room.basePrice,
      imgUrl: room.images.isNotEmpty
          ? room.images.first
          : 'https://lh3.googleusercontent.com/aida-public/AB6AXuDb3RSX6Ngi4Rs7OprYciO4TivMn88JFvJFMoMUboJfSBfU4OAYpuj9gdRgw23hDD1w4Vg0-SxD8nsVNGk7zAYCsIij5sM9zi-0bNVT_U2WZsrlmtlLiL2X8IEe1U05odfhEllXOrHSPXqnUHUb6NigZWGTcZ3wCx9_ClqgTEgFp3lsfYVysIJ1ld5y7ZOz9oZKWYcSdyiJcBRhwIoE_ce9OYPfSeEDgunUY52krm52W2_fIA1izU1a',
      features: room.amenities,
    );
  }

  Widget _buildFilterPill(
    String text, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryContainer
                : AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Text(
            text,
            style: AppTypography.labelSm.copyWith(
              color: isSelected
                  ? AppColors.surfaceContainerLowest
                  : AppColors.primaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
