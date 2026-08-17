import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/booking/domain/repositories/booking_repository.dart';

class DeleteBookingUseCase {
  DeleteBookingUseCase(this.repository);
  final BookingRepository repository;

  Future<Either<Failure, Unit>> call(int id) {
    return repository.deleteBooking(id);
  }
}
