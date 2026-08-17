import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/exceptions.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/core/helpers/network_info.dart';
import 'package:sham_booking/features/booking/data/data_sources/remote_booking_data_source.dart';
import 'package:sham_booking/features/booking/data/models/cancel_request.dart';
import 'package:sham_booking/features/booking/data/models/create_booking_request.dart';
import 'package:sham_booking/features/booking/data/models/find_one_response.dart';
import 'package:sham_booking/features/booking/data/models/get_booking_response.dart';
import 'package:sham_booking/features/booking/data/models/update_booking_request.dart';
import 'package:sham_booking/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  BookingRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final RemoteBookingDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Unit>> createBooking(CreateBookingRequest request) {
    return _execute(
      action: () => remoteDataSource.createBooking(request),
    );
  }

  @override
  Future<Either<Failure, Unit>> updateBooking(UpdateBookingRequest request) {
    return _execute(
      action: () => remoteDataSource.updateBooking(request),
    );
  }

  @override
  Future<Either<Failure, Unit>> cancelBooking(CancelBookingRequest request) {
    return _execute(
      action: () => remoteDataSource.cancelBooking(request),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteBooking(int id) {
    return _execute(
      action: () => remoteDataSource.deleteBooking(id),
    );
  }

  @override
  Future<Either<Failure, FindOneResponse>> findOne(int id) {
    return _execute(
      action: () => remoteDataSource.findOne(id),
    );
  }

  @override
  Future<Either<Failure, GetBookingResponse>> getBooking() {
    return _execute(
      action: remoteDataSource.getBooking,
    );
  }

  Future<Either<Failure, T>> _execute<T>({
    required Future<T> Function() action,
    bool requiresConnection = true,
  }) async {
    if (requiresConnection && !await networkInfo.isConnected) {
      return Left(OfflineFailure());
    }

    try {
      final result = await action();
      return Right(result);
    } on IsFirstOpenException {
      return Left(IsFirstOpenFailure());
    } on NotSignException {
      return Left(NotSignFailure());
    } on ServerFailureException catch (e) {
      return Left(
        ServerFailure(
          message: e.errorModel.message ?? 'Unknown error',
          statusCode: e.errorModel.statusCode,
        ),
      );
    } on NotVerifiedException {
      return Left(NotVerifiedFailure());
    } on UnexpectedException {
      return Left(UnexpectedFailure());
    }
  }
}
