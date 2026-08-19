import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class RoomInfoSection extends StatelessWidget {
  const RoomInfoSection({
    required this.hotelName,
    required this.location,
    required this.rating,
    super.key,
  });

  final String hotelName;
  final String location;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hotelName,
          style: TextStyle(
            color: AppColors.goldAccent,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 12.sp,
          ),
        ),
        12.verticalSpace,
        Row(
          children: [
            const Icon(Icons.location_on, size: 18, color: AppColors.primary),
            6.horizontalSpace,
            Expanded(
              child: Text(
                location,
                style: AppTextStyles.normal14onSurfaceVariantW400,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondaryFixed,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 16,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    rating,
                    style: AppTextStyles.normal12onSurfaceVariantW600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
