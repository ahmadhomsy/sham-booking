import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';

class LoggedInUseCase {
  LoggedInUseCase(this.repository);
  final AuthRepositories repository;

  Future<Either<Failure, bool>> call() async {
    return repository.loggedIn();
  }
}
