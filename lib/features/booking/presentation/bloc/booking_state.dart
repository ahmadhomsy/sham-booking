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
    this.hasPaymentMethod = false,
    this.status = BookingStatus.initial,
    this.errorMessage,
    this.bookingDetails,
    this.bookingsResponse,
  });

  final BookingStatus status;
  final String? errorMessage;
  final FindOneResponse? bookingDetails;
  final GetBookingResponse? bookingsResponse;
  final bool hasPaymentMethod;

  BookingState copyWith({
    BookingStatus? status,
    String? errorMessage,
    FindOneResponse? bookingDetails,
    GetBookingResponse? bookingsResponse,
    bool? hasPaymentMethod,
  }) {
    return BookingState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      bookingDetails: bookingDetails ?? this.bookingDetails,
      bookingsResponse: bookingsResponse ?? this.bookingsResponse,
      hasPaymentMethod: hasPaymentMethod ?? this.hasPaymentMethod,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    bookingDetails,
    bookingsResponse,
    hasPaymentMethod,
  ];
}
