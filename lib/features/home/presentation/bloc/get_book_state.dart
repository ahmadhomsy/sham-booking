part of 'get_book_bloc.dart';

enum GetBookStatus {
  initial,
  loading,
  success,
  failure,
}

class GetBookState extends Equatable {
  const GetBookState({
    this.status = GetBookStatus.initial,
    this.errorMessage,
    this.bookingsResponse,
  });

  final GetBookStatus status;
  final String? errorMessage;
  final GetBookingResponse? bookingsResponse;

  GetBookState copyWith({
    GetBookStatus? status,
    String? errorMessage,
    GetBookingResponse? bookingsResponse,
  }) {
    return GetBookState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      bookingsResponse: bookingsResponse ?? this.bookingsResponse,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    bookingsResponse,
  ];
}
