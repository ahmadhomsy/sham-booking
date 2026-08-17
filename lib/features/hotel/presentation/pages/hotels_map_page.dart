import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class HotelLocationPage extends StatefulWidget {
  const HotelLocationPage({
    required this.latitude,
    required this.longitude,
    required this.hotelName,
    required this.address,
    super.key,
  });

  final double latitude;
  final double longitude;
  final String hotelName;
  final String address;

  @override
  State<HotelLocationPage> createState() => _HotelLocationPageState();
}

class _HotelLocationPageState extends State<HotelLocationPage> {
  GoogleMapController? _mapController;

  late final LatLng _hotelLocation;

  @override
  void initState() {
    super.initState();

    _hotelLocation = LatLng(
      widget.latitude,
      widget.longitude,
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundStart,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _hotelLocation,
              zoom: 16,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('hotel_location'),
                position: _hotelLocation,
                infoWindow: InfoWindow(
                  title: widget.hotelName,
                  snippet: widget.address,
                ),
              ),
            },
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),

          // Back button
          Positioned(
            top: 50,
            left: 16,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 12,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primaryContainer,
                  ),
                ),
              ),
            ),
          ),

          // Hotel information card
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.hotel,
                        color: AppColors.primaryContainer,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.hotelName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryContainer,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            widget.address,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
