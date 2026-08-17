import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/booking/data/models/find_one_response.dart';
import 'package:sham_booking/features/booking/domain/repositories/booking_repository.dart';

class FindOneUseCase {
  FindOneUseCase(this.repository);
  final BookingRepository repository;

  Future<Either<Failure, FindOneResponse>> call(int id) {
    return repository.findOne(id);
  }
}
