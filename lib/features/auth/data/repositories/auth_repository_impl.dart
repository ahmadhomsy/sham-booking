import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/exceptions.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/core/helpers/network_info.dart';
import 'package:sham_booking/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl implements AuthRepositories {
  AuthRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
  });
  final NetworkInfo networkInfo;
  final LocalAuthDataSource localDataSource;

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
    } on ServerException {
      return Left(ServerFailure());
    } on NotVerifiedException {
      return Left(NotVerifiedFailure());
    } on UnexpectedException {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> loggedIn() async {
    return _execute(
      action: localDataSource.loggedIn,
      requiresConnection: false,
    );
  }
}
