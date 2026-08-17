import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';
import 'package:sham_booking/features/home/domain/repositories/hotel_repository.dart';

class GetHotelDetailsUseCase {
  GetHotelDetailsUseCase(this.repository);
  final HotelRepository repository;

  Future<Either<Failure, HotelModel>> call(int id) {
    return repository.getHotelDetails(id);
  }
}
