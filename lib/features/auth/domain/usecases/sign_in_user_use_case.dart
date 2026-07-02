import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/auth/data/models/sign_in_user_request_model.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';

class SignInUserUseCase {
  SignInUserUseCase(this.repositories);
  final AuthRepositories repositories;
  Future<Either<Failure, String>> call(SignInUserRequestModel request) {
    return repositories.signInUser(request);
  }
}
