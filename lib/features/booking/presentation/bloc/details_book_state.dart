part of 'details_book_bloc.dart';

enum DetailsBookStatus {
  initial,
  loading,
  success,
  failure,
}

class DetailsBookState extends Equatable {
  const DetailsBookState({
    this.status = DetailsBookStatus.initial,
    this.errorMessage,
    this.bookingDetails,
  });

  final DetailsBookStatus status;
  final String? errorMessage;
  // تأكد من استيراد FindOneResponse من ملف المودل الخاص بك
  final FindOneResponse? bookingDetails;

  DetailsBookState copyWith({
    DetailsBookStatus? status,
    String? errorMessage,
    FindOneResponse? bookingDetails,
  }) {
    return DetailsBookState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      bookingDetails: bookingDetails ?? this.bookingDetails,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    bookingDetails,
  ];
}
