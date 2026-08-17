import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/booking/data/models/get_booking_response.dart';
import 'package:sham_booking/features/booking/domain/repositories/booking_repository.dart';

class GetBookingUseCase {
  GetBookingUseCase(this.repository);
  final BookingRepository repository;

  Future<Either<Failure, GetBookingResponse>> call() {
    return repository.getBooking();
  }
}
