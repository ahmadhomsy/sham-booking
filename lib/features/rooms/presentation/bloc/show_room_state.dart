part of 'show_room_bloc.dart';

enum ShowRoomStatus { initial, loading, success, failure }

class ShowRoomState extends Equatable {
  const ShowRoomState({
    this.status = ShowRoomStatus.initial,
    this.room,
    this.errorMessage = '',
  });

  final ShowRoomStatus status;
  final RoomData? room;
  final String errorMessage;

  bool get isLoading => status == ShowRoomStatus.loading;
  bool get isSuccess => status == ShowRoomStatus.success;
  bool get isFailure => status == ShowRoomStatus.failure;

  ShowRoomState copyWith({
    ShowRoomStatus? status,
    RoomData? room,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return ShowRoomState(
      status: status ?? this.status,
      room: room ?? this.room,
      errorMessage: clearErrorMessage ? '' : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, room, errorMessage];
}
