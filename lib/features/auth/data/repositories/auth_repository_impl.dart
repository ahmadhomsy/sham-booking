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

class AuthRepositoryImpl implements AuthRepositories {
  AuthRepositoryImpl({
    required this.remoteAuthDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  final NetworkInfo networkInfo;
  final LocalAuthDataSource localDataSource;
  final RemoteAuthDataSource remoteAuthDataSource;

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
  Future<Either<Failure, bool>> loggedIn() {
    return _execute(
      action: localDataSource.loggedIn,
      requiresConnection: false,
    );
  }

  @override
  Future<Either<Failure, Unit>> sendVerificationCode() {
    return _execute(
      action: () async {
        final email = await localDataSource.getEmail();
        return remoteAuthDataSource.sendVerificationCode(email);
      },
    );
  }

  @override
  Future<Either<Failure, String>> signInUser(SignInUserRequestModel request) {
    return _execute(
      action: () async {
        final response = await remoteAuthDataSource.signIn(request);
        await localDataSource.saveSignInUser(response);
        await localDataSource.saveVerified(isVerified: true);
        return response.userData?.userInfo?.role ?? '';
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> signUpUser(SignUpUserRequestModel request) {
    return _execute(
      action: () async {
        final response = await remoteAuthDataSource.signUp(request);
        await localDataSource.saveSignUpUser(response);
        await localDataSource.saveVerified(isVerified: false);
        return unit;
      },
    );
  }

  @override
  Future<Either<Failure, String>> verifyVerificationCode(String code) {
    return _execute(
      action: () async {
        final email = await localDataSource.getEmail();
        await remoteAuthDataSource.verifyVerificationCode(code, email);
        await localDataSource.saveVerified(isVerified: true);
        return localDataSource.getRole();
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> getProfile() {
    return _execute(
      action: () async {
        final response = await remoteAuthDataSource.getProfile();
        await localDataSource.saveProfile(response);
        return unit;
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updateProfile(UserInfoRequest request) {
    return _execute(
      action: () async {
        await remoteAuthDataSource.updateProfile(request);
        return unit;
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> logout(String token) {
    return _execute(
      action: () async {
        return localDataSource.logout();
      },
      requiresConnection: false,
    );
  }
}
