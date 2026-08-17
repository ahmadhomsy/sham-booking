part of 'booking_bloc.dart';

enum BookingStatus {
  initial,
  loading,
  failure,
  createSuccess,
  cancelSuccess,
  deleteSuccess,
  findOneSuccess,
  getSuccess,
  updateSuccess,
  updateUserSuccess,
}

class BookingState extends Equatable {
  const BookingState({
    this.status = BookingStatus.initial,
    this.errorMessage,
    this.bookingDetails,
    this.bookingsResponse,
  });

  final BookingStatus status;
  final String? errorMessage;
  final FindOneResponse? bookingDetails;
  final GetBookingResponse? bookingsResponse;

  BookingState copyWith({
    BookingStatus? status,
    String? errorMessage,
    FindOneResponse? bookingDetails,
    GetBookingResponse? bookingsResponse,
  }) {
    return BookingState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      bookingDetails: bookingDetails ?? this.bookingDetails,
      bookingsResponse: bookingsResponse ?? this.bookingsResponse,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    bookingDetails,
    bookingsResponse,
  ];
}
