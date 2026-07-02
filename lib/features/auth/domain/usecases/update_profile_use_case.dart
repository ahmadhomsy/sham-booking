import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/auth/data/models/user_info_request.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';

class UpdateProfileUseCase {
  UpdateProfileUseCase(this.repositories);
  final AuthRepositories repositories;
  Future<Either<Failure, Unit>> call(UserInfoRequest request) {
    return repositories.updateProfile(request);
  }
}
