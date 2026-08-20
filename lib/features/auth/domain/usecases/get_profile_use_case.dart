import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/auth/data/models/get_profile_response_local.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';

class GetProfileUseCase {
  GetProfileUseCase(this.repositories);
  final AuthRepositories repositories;
  Future<Either<Failure, GetProfileResponseLocal>> call() {
    return repositories.getProfile();
  }
}
