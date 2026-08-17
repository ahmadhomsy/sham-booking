import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/booking/data/models/cancel_request.dart';
import 'package:sham_booking/features/booking/data/models/create_booking_request.dart';
import 'package:sham_booking/features/booking/data/models/find_one_response.dart';
import 'package:sham_booking/features/booking/data/models/get_booking_response.dart';
import 'package:sham_booking/features/booking/data/models/update_booking_request.dart';

abstract class BookingRepository {
  Future<Either<Failure, Unit>> createBooking(CreateBookingRequest request);
  Future<Either<Failure, GetBookingResponse>> getBooking();
  Future<Either<Failure, FindOneResponse>> findOne(int id);
  Future<Either<Failure, Unit>> deleteBooking(int id);
  Future<Either<Failure, Unit>> updateBooking(UpdateBookingRequest request);
  Future<Either<Failure, Unit>> cancelBooking(CancelBookingRequest request);
}
