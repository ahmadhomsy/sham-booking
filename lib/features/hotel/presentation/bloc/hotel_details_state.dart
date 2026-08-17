part of 'hotel_details_bloc.dart';

enum HotelDetailsStatus { initial, loading, success, failure }

enum HotelDetailsRoomsFilter { all, available }

class HotelDetailsState {
  HotelDetailsState({
    this.hotelStatus = HotelDetailsStatus.initial,
    this.roomsStatus = HotelDetailsStatus.initial,
    this.selectedFilter = HotelDetailsRoomsFilter.all,
    this.hotel,
    this.rooms = const [],
    this.availableRooms = const [],
    this.hotelErrorMessage,
    this.roomsErrorMessage,
  });

  final HotelDetailsStatus hotelStatus;
  final HotelDetailsStatus roomsStatus;
  final HotelDetailsRoomsFilter selectedFilter;
  final HotelModel? hotel;
  final List<HotelRoomModel> rooms;
  final List<AvailableRoomModel> availableRooms;
  final String? hotelErrorMessage;
  final String? roomsErrorMessage;

  HotelDetailsState copyWith({
    HotelDetailsStatus? hotelStatus,
    HotelDetailsStatus? roomsStatus,
    HotelDetailsRoomsFilter? selectedFilter,
    HotelModel? hotel,
    List<HotelRoomModel>? rooms,
    List<AvailableRoomModel>? availableRooms,
    String? hotelErrorMessage,
    String? roomsErrorMessage,
    bool clearHotelErrorMessage = false,
    bool clearRoomsErrorMessage = false,
  }) {
    return HotelDetailsState(
      hotelStatus: hotelStatus ?? this.hotelStatus,
      roomsStatus: roomsStatus ?? this.roomsStatus,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      hotel: hotel ?? this.hotel,
      rooms: rooms ?? this.rooms,
      availableRooms: availableRooms ?? this.availableRooms,
      hotelErrorMessage: clearHotelErrorMessage
          ? hotelErrorMessage
          : hotelErrorMessage ?? this.hotelErrorMessage,
      roomsErrorMessage: clearRoomsErrorMessage
          ? roomsErrorMessage
          : roomsErrorMessage ?? this.roomsErrorMessage,
    );
  }
}
