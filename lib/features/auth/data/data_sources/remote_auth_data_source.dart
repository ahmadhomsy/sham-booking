import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/api/api_consumer.dart';
import 'package:sham_booking/core/api/end_points.dart';
import 'package:sham_booking/features/auth/data/models/get_profile_response.dart';
import 'package:sham_booking/features/auth/data/models/sign_in_response.dart';
import 'package:sham_booking/features/auth/data/models/sign_in_user_request_model.dart';
import 'package:sham_booking/features/auth/data/models/sign_up_response.dart';
import 'package:sham_booking/features/auth/data/models/sign_up_user_request_model.dart';
import 'package:sham_booking/features/auth/data/models/update_profile_response.dart';
import 'package:sham_booking/features/auth/data/models/user_info_request.dart';

abstract class RemoteAuthDataSource {
  Future<SignInResponse> signIn(SignInUserRequestModel request);
  Future<SignUpResponse> signUp(SignUpUserRequestModel request);
  Future<UpdateProfileResponse> updateProfile(UserInfoRequest request);
  Future<GetProfileResponse> getProfile();
  Future<Unit> verifyVerificationCode(String code, String email);
  Future<Unit> sendVerificationCode(String email);
}

class RemoteAuthDataSourceImpl implements RemoteAuthDataSource {
  RemoteAuthDataSourceImpl(this.apiConsumer);
  final ApiConsumer apiConsumer;
  @override
  Future<GetProfileResponse> getProfile() async {
    final response = await apiConsumer.get(EndPoints.getProfile);
    return GetProfileResponse.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<Unit> sendVerificationCode(String email) async {
    await apiConsumer.post(
      EndPoints.sendVerificationCode,
      data: {
        'email': email,
      },
    );
    return unit;
  }

  @override
  Future<SignInResponse> signIn(SignInUserRequestModel request) async {
    final response = await apiConsumer.post(
      EndPoints.login,
      data: request.toJson(),
    );
    return SignInResponse.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<SignUpResponse> signUp(SignUpUserRequestModel request) async {
    final response = await apiConsumer.post(
      EndPoints.register,
      data: request.toJson(),
    );
    return SignUpResponse.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<Unit> verifyVerificationCode(String code, String email) async {
    await apiConsumer.post(
      EndPoints.verifyCode,
      data: {
        'email': email,
        'code': code,
      },
    );
    return unit;
  }

  @override
  Future<UpdateProfileResponse> updateProfile(UserInfoRequest request) async {
    final response = await apiConsumer.patch(
      EndPoints.updateProfile,
      data: request.toJson(),
    );
    return UpdateProfileResponse.fromJson(response as Map<String, dynamic>);
  }
}
