import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/booking/data/models/cancel_request.dart';
import 'package:sham_booking/features/booking/domain/repositories/booking_repository.dart';

class CancelBookingUseCase {
  CancelBookingUseCase(this.repository);
  final BookingRepository repository;

  Future<Either<Failure, Unit>> call(CancelBookingRequest request) {
    return repository.cancelBooking(request);
  }
}
