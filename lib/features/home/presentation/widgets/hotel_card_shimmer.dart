import 'package:flutter/material.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class HotelCardShimmer extends StatelessWidget {
  const HotelCardShimmer({super.key});

  Widget _box({
    required double height,
    required double width,
    double radius = 8,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.outlineVariant,
      highlightColor: AppColors.surfaceContainerLowest,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            _box(
              height: 250,
              width: double.infinity,
              radius: 0,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel name
                  _box(
                    height: 28,
                    width: 220,
                  ),

                  12.verticalSpace,

                  // Location
                  Row(
                    children: [
                      _box(
                        height: 16,
                        width: 16,
                        radius: 4,
                      ),
                      8.horizontalSpace,
                      _box(
                        height: 16,
                        width: 180,
                      ),
                    ],
                  ),

                  20.verticalSpace,

                  // Description
                  _box(
                    height: 14,
                    width: double.infinity,
                  ),

                  8.verticalSpace,

                  _box(
                    height: 14,
                    width: 260,
                  ),

                  20.verticalSpace,

                  const Divider(
                    height: 1,
                    color: AppColors.outlineVariant,
                  ),

                  16.verticalSpace,

                  // Contact chips
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _chip(),
                      _chip(),
                      _chip(),
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

  Widget _chip() {
    return Container(
      height: 32,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
