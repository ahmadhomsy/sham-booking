part of 'hotel_bloc.dart';

@immutable
sealed class HotelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllHotelsEvent extends HotelEvent {}

class RefreshHotelsEvent extends HotelEvent {}

class GetHotelDetailsEvent extends HotelEvent {
  GetHotelDetailsEvent({required this.id});
  final int id;
  @override
  List<Object> get props => [id];
}
