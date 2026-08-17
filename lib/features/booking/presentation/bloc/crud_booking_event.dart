part of 'crud_booking_bloc.dart';

abstract class CrudBookingEvent extends Equatable {
  const CrudBookingEvent();

  @override
  List<Object?> get props => [];
}

class SubmitCancelBookingEvent extends CrudBookingEvent {
  const SubmitCancelBookingEvent(this.request);

  final CancelBookingRequest request;

  @override
  List<Object?> get props => [request];
}

class SubmitDeleteBookingEvent extends CrudBookingEvent {
  const SubmitDeleteBookingEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

class SubmitUpdateBookingEvent extends CrudBookingEvent {
  const SubmitUpdateBookingEvent(this.request);

  final UpdateBookingRequest request;

  @override
  List<Object?> get props => [request];
}
