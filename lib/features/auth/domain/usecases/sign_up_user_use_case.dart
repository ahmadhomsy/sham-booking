import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/auth/data/models/sign_up_user_request_model.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';

class SignUpUserUseCase {
  SignUpUserUseCase(this.repositories);
  final AuthRepositories repositories;
  Future<Either<Failure, Unit>> call(SignUpUserRequestModel request) {
    return repositories.signUpUser(request);
  }
}
