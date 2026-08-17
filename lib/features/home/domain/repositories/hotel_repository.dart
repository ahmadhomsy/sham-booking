import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';

abstract class HotelRepository {
  Future<Either<Failure, List<HotelModel>>> getAllHotels();
  Future<Either<Failure, HotelModel>> getHotelDetails(int id);
}
