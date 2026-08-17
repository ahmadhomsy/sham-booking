import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';

class LogoutUseCase {
  LogoutUseCase(this.repositories);
  final AuthRepositories repositories;
  Future<Either<Failure, Unit>> call() {
    return repositories.logout();
  }
}
