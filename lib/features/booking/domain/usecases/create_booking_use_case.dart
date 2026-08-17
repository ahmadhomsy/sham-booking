import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/booking/data/models/create_booking_request.dart';
import 'package:sham_booking/features/booking/domain/repositories/booking_repository.dart';

class CreateBookingUseCase {
  CreateBookingUseCase(this.repository);
  final BookingRepository repository;

  Future<Either<Failure, Unit>> call(CreateBookingRequest request) {
    return repository.createBooking(request);
  }
}
