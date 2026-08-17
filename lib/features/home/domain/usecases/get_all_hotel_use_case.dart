import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';
import 'package:sham_booking/features/home/domain/repositories/hotel_repository.dart';

class GetAllHotelUseCase {
  GetAllHotelUseCase(this.repository);
  final HotelRepository repository;
  Future<Either<Failure, List<HotelModel>>> call() {
    return repository.getAllHotels();
  }
}
