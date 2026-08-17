import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';
import 'package:sham_booking/features/home/presentation/widgets/map_back_button.dart';
import 'package:sham_booking/features/home/presentation/widgets/map_hotel_summary_card.dart';

class HotelsMapPage extends StatefulWidget {
  const HotelsMapPage({required this.hotels, super.key});
  final List<HotelModel> hotels;

  @override
  State<HotelsMapPage> createState() => _HotelsMapPageState();
}

class _HotelsMapPageState extends State<HotelsMapPage> {
  GoogleMapController? _mapController;
  final ValueNotifier<HotelModel?> _selectedHotelNotifier = ValueNotifier(null);
  late final Set<Marker> _markers;

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(33.5138, 36.2765),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _markers = _buildMarkers();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _selectedHotelNotifier.dispose();
    super.dispose();
  }

  Set<Marker> _buildMarkers() {
    return widget.hotels.map((hotel) {
      final lat = double.tryParse(hotel.mapLatitude ?? '') ?? 33.5138;
      final lng = double.tryParse(hotel.mapLongitude ?? '') ?? 36.2765;
      final location = LatLng(lat, lng);

      return Marker(
        markerId: MarkerId(hotel.id.toString()),
        position: location,
        onTap: () async {
          _selectedHotelNotifier.value = hotel;
          await _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(location, 14),
          );
        },
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundStart,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            mapToolbarEnabled: false,
            markers: _markers,
            onMapCreated: (controller) => _mapController = controller,
            onTap: (_) {
              if (_selectedHotelNotifier.value != null) {
                _selectedHotelNotifier.value = null;
              }
            },
          ),
          MapBackButton(onPressed: () => context.pop()),

          ValueListenableBuilder<HotelModel?>(
            valueListenable: _selectedHotelNotifier,
            builder: (context, selectedHotel, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                bottom: selectedHotel != null ? 24 : -200,
                left: 16,
                right: 16,
                child: selectedHotel != null
                    ? MapHotelSummaryCard(hotel: selectedHotel)
                    : const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }
}
