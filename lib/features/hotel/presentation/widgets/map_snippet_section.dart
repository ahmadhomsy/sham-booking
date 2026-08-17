import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class AppTypography {
  static final TextStyle labelSm = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1,
    letterSpacing: 0.6,
  );

  static final TextStyle bodyMd = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
}

class MapSnippetSection extends StatefulWidget {
  const MapSnippetSection({
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.hotelName,
    super.key,
  });

  final String address;
  final double? latitude;
  final double? longitude;
  final String hotelName;

  @override
  State<MapSnippetSection> createState() => _MapSnippetSectionState();
}

class _MapSnippetSectionState extends State<MapSnippetSection> {
  GoogleMapController? _mapController;

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _openFullMap() {
    if (widget.latitude == null || widget.longitude == null) {
      return;
    }

    context.pushNamed(
      'hotelLocation',
      queryParameters: {
        'latitude': widget.latitude.toString(),
        'longitude': widget.longitude.toString(),
        'hotelName': widget.hotelName,
        'address': widget.address,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final latitude = widget.latitude;
    final longitude = widget.longitude;

    if (latitude == null || longitude == null) {
      return _buildUnavailableMap();
    }

    final location = LatLng(latitude, longitude);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'hotel_details.location'.tr(),
          style: GoogleFonts.notoSerif(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryContainer,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          widget.address,
          style: AppTypography.bodyMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),

        const SizedBox(height: 16),

        GestureDetector(
          onTap: _openFullMap,
          child: Container(
            height: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(15, 32, 64, 0.08),
                  blurRadius: 20,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: location,
                      zoom: 15,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('hotel_location'),
                        position: location,
                        infoWindow: InfoWindow(
                          title: widget.hotelName,
                          snippet: widget.address,
                        ),
                      ),
                    },
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                    rotateGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    scrollGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                  ),

                  // طبقة خفيفة فوق الخريطة
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.primaryContainer.withValues(
                                alpha: 0.08,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // زر فتح الخريطة
                  Positioned(
                    right: 16,
                    top: 16,
                    child: Material(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 4,
                      child: InkWell(
                        onTap: _openFullMap,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.open_in_full_rounded,
                                size: 18,
                                color: AppColors.primaryContainer,
                              ),
                              const SizedBox(width: 7),
                              Text(
                                'View Map',
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.primaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // اسم الفندق في الأسفل
                  // Positioned(
                  //   left: 16,
                  //   right: 16,
                  //   bottom: 16,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 14,
                  //       vertical: 12,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: AppColors.primaryContainer.withValues(
                  //         alpha: 0.94,
                  //       ),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         Container(
                  //           width: 38,
                  //           height: 38,
                  //           decoration: BoxDecoration(
                  //             color: AppColors.secondaryContainer,
                  //             borderRadius: BorderRadius.circular(8),
                  //           ),
                  //           child: const Icon(
                  //             Icons.hotel_rounded,
                  //             color: AppColors.primaryContainer,
                  //             size: 20,
                  //           ),
                  //         ),
                  //
                  //         const SizedBox(width: 10),
                  //
                  //         Expanded(
                  //           child: Text(
                  //             widget.hotelName,
                  //             maxLines: 1,
                  //             overflow: TextOverflow.ellipsis,
                  //             style: AppTypography.bodyMd.copyWith(
                  //               color: AppColors.surfaceContainerLowest,
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //           ),
                  //         ),
                  //
                  //         const Icon(
                  //           Icons.arrow_forward_ios_rounded,
                  //           size: 15,
                  //           color: AppColors.secondaryContainer,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUnavailableMap() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_off_outlined,
              size: 40,
              color: AppColors.outline,
            ),
            const SizedBox(height: 10),
            Text(
              'Location unavailable',
              style: AppTypography.bodyMd.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
