part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class SubmitCreateBookingEvent extends BookingEvent {
  const SubmitCreateBookingEvent({
    required this.request,
    required this.isStripe,
  });

  final CreateBookingRequest request;
  final bool isStripe;

  @override
  List<Object?> get props => [request, isStripe];
}

class SubmitUpdateUserEvent extends BookingEvent {
  const SubmitUpdateUserEvent(this.request);
  final UserInfoRequest request;

  @override
  List<Object?> get props => [request];
}
