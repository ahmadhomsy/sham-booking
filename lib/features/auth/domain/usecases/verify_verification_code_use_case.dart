import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';

class VerifyVerificationCodeUseCase {
  VerifyVerificationCodeUseCase(this.repositories);
  final AuthRepositories repositories;
  Future<Either<Failure, String>> call(String code) {
    return repositories.verifyVerificationCode(code);
  }
}
