part of 'hotel_details_bloc.dart';

@immutable
sealed class HotelDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HotelDetailsStarted extends HotelDetailsEvent {}

class HotelDetailsRoomsFilterChanged extends HotelDetailsEvent {
  HotelDetailsRoomsFilterChanged(this.filter);
  final HotelDetailsRoomsFilter filter;

  @override
  List<Object> get props => [filter];
}
