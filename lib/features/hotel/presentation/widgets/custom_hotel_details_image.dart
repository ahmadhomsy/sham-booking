import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class CustomHotelDetailsImage extends StatelessWidget {
  const CustomHotelDetailsImage({
    required this.imageUrl,
    super.key,
    this.height = 250,
    this.width = double.infinity,
    this.borderRadius = 0.0,
  });
  final String? imageUrl;
  final double height;
  final double width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildFallbackImage();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        height: height,
        width: width,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildLoadingState(),
        errorWidget: (context, url, error) => _buildFallbackImage(),
      ),
    );
  }

  Widget _buildFallbackImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        'assets/images/hotel_placeholder.png',
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.outlineVariant.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
