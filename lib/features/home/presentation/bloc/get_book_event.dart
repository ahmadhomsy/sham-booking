part of 'get_book_bloc.dart';

abstract class GetBookEvent extends Equatable {
  const GetBookEvent();

  @override
  List<Object?> get props => [];
}

class SubmitGetBookingEvent extends GetBookEvent {}
