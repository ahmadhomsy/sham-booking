import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/exceptions.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/core/helpers/network_info.dart';
import 'package:sham_booking/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:sham_booking/features/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:sham_booking/features/auth/data/models/sign_in_user_request_model.dart';
import 'package:sham_booking/features/auth/data/models/sign_up_user_request_model.dart';
import 'package:sham_booking/features/auth/data/models/user_info_request.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';
import 'package:sham_booking/features/home/data/data_sources/hotel_local_data_source.dart';
import 'package:sham_booking/features/home/data/data_sources/hotel_remote_data_source.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';
import 'package:sham_booking/features/home/domain/repositories/hotel_repository.dart';

class HotelRepositoryImpl implements HotelRepository {
  HotelRepositoryImpl({
    required this.hotelRemoteDataSource,
    required this.networkInfo,
    required this.hotelLocalDataSource,
  });

  final NetworkInfo networkInfo;
  final HotelLocalDataSource hotelLocalDataSource;
  final HotelRemoteDataSource hotelRemoteDataSource;

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

  @override
  Future<Either<Failure, List<HotelModel>>> getAllHotels() {
    return _execute(
      action: () async {
        final response = await hotelRemoteDataSource.getAllHotels();
        return response;
      },
    );
  }

  @override
  Future<Either<Failure, HotelModel>> getHotelDetails(int id) {
    return _execute(
      action: () async {
        final response = await hotelRemoteDataSource.getHotelDetails(id);
        return response;
      },
    );
  }
}
