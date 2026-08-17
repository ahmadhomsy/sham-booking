part of 'show_room_bloc.dart';

abstract class ShowRoomEvent extends Equatable {
  const ShowRoomEvent();

  @override
  List<Object?> get props => [];
}

class ShowRoomStarted extends ShowRoomEvent {
  const ShowRoomStarted();
}
