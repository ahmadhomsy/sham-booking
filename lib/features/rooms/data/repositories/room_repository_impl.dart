import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/exceptions.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/core/helpers/network_info.dart';
import 'package:sham_booking/features/rooms/data/data_sources/local_room_data_source.dart';
import 'package:sham_booking/features/rooms/data/data_sources/remote_room_data_source.dart';
import 'package:sham_booking/features/rooms/data/models/get_available_room_response.dart';
import 'package:sham_booking/features/rooms/data/models/get_hotel_room_response.dart';
import 'package:sham_booking/features/rooms/data/models/get_room_response.dart';
import 'package:sham_booking/features/rooms/data/models/show_room_response.dart';
import 'package:sham_booking/features/rooms/domain/repositories/room_repositories.dart';

class RoomRepositoryImpl implements RoomRepository {
  RoomRepositoryImpl({
    required this.remoteAuthDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  final NetworkInfo networkInfo;
  final LocalRoomDataSource localDataSource;
  final RemoteRoomDataSource remoteAuthDataSource;

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
  Future<Either<Failure, GetAvailableRoomResponse>> getAvailableRoom() {
    return _execute(
      action: () => remoteAuthDataSource.getAvailableRoom(),
    );
  }

  @override
  Future<Either<Failure, GetRoomResponse>> getRoom(int id) {
    return _execute(
      action: () => remoteAuthDataSource.getRoom(id),
    );
  }

  @override
  Future<Either<Failure, ShowRoomResponse>> showRoom(int id) {
    return _execute(
      action: () => remoteAuthDataSource.showRoom(id),
    );
  }

  @override
  Future<Either<Failure, GetHotelRoomResponse>> getHotelRoom(int id) {
    return _execute(
      action: () => remoteAuthDataSource.getHotelRoom(id),
    );
  }
}
