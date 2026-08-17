part of 'home_rooms_bloc.dart';

enum HomeRoomsStatus {
  initial,
  loading,
  success,
  failure,
}

class HomeRoomsState {
  HomeRoomsState({
    this.status = HomeRoomsStatus.initial,
    this.availableRooms = const [],
    this.errorMessage,
  });

  final HomeRoomsStatus status;
  final List<AvailableRoomModel> availableRooms;
  final String? errorMessage;

  HomeRoomsState copyWith({
    HomeRoomsStatus? status,
    List<AvailableRoomModel>? availableRooms,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return HomeRoomsState(
      status: status ?? this.status,
      availableRooms: availableRooms ?? this.availableRooms,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }
}
