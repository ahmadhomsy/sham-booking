import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/booking/data/models/update_booking_request.dart';
import 'package:sham_booking/features/booking/domain/repositories/booking_repository.dart';

class UpdateBookingUseCase {
  UpdateBookingUseCase(this.repository);
  final BookingRepository repository;

  Future<Either<Failure, Unit>> call(UpdateBookingRequest request) {
    return repository.updateBooking(request);
  }
}
