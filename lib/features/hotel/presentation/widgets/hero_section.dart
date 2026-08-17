import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sham_booking/core/helpers/share_service.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/features/home/presentation/widgets/custom_hotel_image.dart';
import 'package:sham_booking/features/hotel/presentation/widgets/custom_hotel_details_image.dart';

class AppTypography {
  static final TextStyle h1 = GoogleFonts.notoSerif(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.8,
  );
  static final TextStyle bodyLg = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );
  static final TextStyle labelSm = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0.6,
  );
}

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.title,
    required this.location,
    this.imageUrl,
    this.rating,
    this.isLoading = false,
    this.errorMessage,
  });

  final String? imageUrl;
  final String title;
  final String location;
  final String? rating;
  final bool isLoading;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomHotelDetailsImage(
            imageUrl: imageUrl,
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  const Color(0xFF000920).withOpacity(0.2),
                  const Color(0xFF000920).withOpacity(0.8),
                ],
              ),
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.secondaryContainer,
              ),
            ),
          Positioned(
            top: 40,
            left: 16,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primaryContainer,
                ),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.share,
                  color: AppColors.primaryContainer,
                ),
                onPressed: () async {
                  await shareLink('http/....');
                },
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (rating != null)
                  Row(
                    children: [
                      ...List.generate(
                        4,
                        (index) => const Icon(
                          Icons.star,
                          color: AppColors.secondaryContainer,
                          size: 20,
                        ),
                      ),
                      const Icon(
                        Icons.star_half,
                        color: AppColors.secondaryContainer,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating!,
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.surfaceContainerLowest,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: AppTypography.h1.copyWith(
                    color: AppColors.surfaceContainerLowest,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.surfaceContainerLowest,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        location,
                        style: AppTypography.bodyLg.copyWith(
                          color: AppColors.surfaceContainerLowest.withOpacity(
                            0.9,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    errorMessage!,
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.secondaryContainer,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
