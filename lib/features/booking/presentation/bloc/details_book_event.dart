part of 'details_book_bloc.dart';

abstract class DetailsBookEvent extends Equatable {
  const DetailsBookEvent();

  @override
  List<Object?> get props => [];
}

class FetchBookingDetailsEvent extends DetailsBookEvent {}
