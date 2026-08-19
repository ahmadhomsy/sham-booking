import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/auth/data/models/get_profile_response_local.dart';
import 'package:sham_booking/features/auth/data/models/sign_in_user_request_model.dart';
import 'package:sham_booking/features/auth/data/models/sign_up_user_request_model.dart';
import 'package:sham_booking/features/auth/data/models/user_info_request.dart';

abstract class AuthRepositories {
  Future<Either<Failure, bool>> loggedIn();
  Future<Either<Failure, String>> signInUser(SignInUserRequestModel request);
  Future<Either<Failure, Unit>> signUpUser(SignUpUserRequestModel request);
  Future<Either<Failure, Unit>> sendVerificationCode();
  Future<Either<Failure, String>> verifyVerificationCode(String code);
  Future<Either<Failure, Unit>> updateProfile(UserInfoRequest request);
  Future<Either<Failure, GetProfileResponseLocal>> getProfile();
  Future<Either<Failure, Unit>> logout();
}
