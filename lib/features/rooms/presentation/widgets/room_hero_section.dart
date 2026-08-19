import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/hotel/presentation/widgets/custom_room_image.dart';

class RoomHeroSection extends StatelessWidget {
  const RoomHeroSection({
    required this.imageUrl,
    required this.roomName,
    required this.isLoading,
    super.key,
  });

  final String imageUrl;
  final String roomName;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320,
      pinned: true,
      backgroundColor: AppColors.surfaceContainerLowest,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: AppColors.primaryFixedDim.withValues(alpha: 0.3),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: isLoading
            ? null
            : Text(
                roomName,
                style: AppTextStyles.normal16primaryW700,
              ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            CustomRoomImage(imageUrl: imageUrl),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black26,
                    Colors.transparent,
                    Colors.black54,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
