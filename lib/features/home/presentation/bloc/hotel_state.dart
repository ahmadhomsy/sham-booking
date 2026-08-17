part of 'hotel_bloc.dart';

enum HotelStatus { initial, loading, success, failure, successVerify }

class HotelState {
  HotelState({
    this.status = HotelStatus.initial,
    this.errorMessage,
    this.hotel,
    this.hotels,
  });

  final HotelStatus status;
  final List<HotelModel>? hotels;
  final HotelModel? hotel;
  final String? errorMessage;

  HotelState copyWith({
    HotelStatus? status,
    List<HotelModel>? hotels,
    HotelModel? hotel,
    String? errorMessage,
  }) {
    return HotelState(
      status: status ?? this.status,
      hotels: hotels ?? this.hotels,
      hotel: hotel ?? this.hotel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
