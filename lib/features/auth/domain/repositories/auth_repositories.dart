import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';

abstract class AuthRepositories {
  Future<Either<Failure, bool>> loggedIn();
}
