part of 'crud_booking_bloc.dart';

enum CrudBookingStatus {
  initial,
  loading,
  cancelSuccess,
  deleteSuccess,
  updateSuccess,
  failure,
}

class CrudBookingState extends Equatable {
  const CrudBookingState({
    this.status = CrudBookingStatus.initial,
    this.errorMessage,
  });

  final CrudBookingStatus status;
  final String? errorMessage;

  CrudBookingState copyWith({
    CrudBookingStatus? status,
    String? errorMessage,
  }) {
    return CrudBookingState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
