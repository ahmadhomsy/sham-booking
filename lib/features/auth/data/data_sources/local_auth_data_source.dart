import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/error/exceptions.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';
import 'package:sham_booking/features/auth/data/models/get_profile_response.dart';
import 'package:sham_booking/features/auth/data/models/get_profile_response_local.dart';
import 'package:sham_booking/features/auth/data/models/sign_in_response.dart';
import 'package:sham_booking/features/auth/data/models/sign_up_response.dart';

abstract class LocalAuthDataSource {
  Future<bool> loggedIn();
  Future<Unit> saveSignUpUser(SignUpResponse signUpResponse);
  Future<Unit> saveSignInUser(SignInResponse signInResponse);
  Future<Unit> saveProfile(GetProfileResponse getProfileResponse);
  Future<Unit> saveVerified({required bool isVerified});
  Future<Unit> logout();
  Future<String> getRole();
  Future<String> getEmail();
  Future<GetProfileResponseLocal> getProfile();
  Future<Unit> hasPaymentMethod();
}

class LocalAuthDataSourceImpl implements LocalAuthDataSource {
  LocalAuthDataSourceImpl({required this.secureStorage});
  final FlutterSecureStorage secureStorage;

  @override
  Future<bool> loggedIn() async {
    if (box.read<bool>(isFirstOpenKey) == null) {
      throw IsFirstOpenException();
    } else if (box.read<bool>(isVerifiedKey) == null) {
      throw NotSignException();
    } else {
      return box.read<bool>(isVerifiedKey)!;
    }
  }

  @override
  Future<Unit> logout() async {
    final isFirstOpenValue = box.read<bool>(isFirstOpenKey) ?? false;
    await box.erase();
    await box.write(isFirstOpenKey, isFirstOpenValue);
    await secureStorage.deleteAll();
    return unit;
  }

  @override
  Future<Unit> saveSignInUser(SignInResponse signInResponse) async {
    final accessToken = signInResponse.userData?.accessToken;
    final refreshToken = signInResponse.userData?.refreshToken;

    if (accessToken != null) {
      await secureStorage.write(key: accessTokenKey, value: accessToken);
    }
    if (refreshToken != null) {
      await secureStorage.write(key: refreshTokenKey, value: refreshToken);
    }

    final safeUserData = signInResponse.userData;

    await box.write(userKey, safeUserData?.userInfo?.toJson());
    await box.write(userId, safeUserData?.userInfo?.id);

    return unit;
  }

  @override
  Future<Unit> saveSignUpUser(SignUpResponse signUpResponse) async {
    final accessToken = signUpResponse.userData?.accessToken;
    final refreshToken = signUpResponse.userData?.refreshToken;

    if (accessToken != null) {
      await secureStorage.write(key: accessTokenKey, value: accessToken);
    }
    if (refreshToken != null) {
      await secureStorage.write(key: refreshTokenKey, value: refreshToken);
    }

    final safeUserData = signUpResponse.userData;

    await box.write(userKey, safeUserData?.userInfo?.toJson());
    await box.write(userId, safeUserData?.userInfo?.id);

    return unit;
  }

  @override
  Future<Unit> saveVerified({required bool isVerified}) async {
    await box.write(isVerifiedKey, isVerified);
    return unit;
  }

  @override
  Future<Unit> saveProfile(GetProfileResponse getProfileResponse) async {
    final encodedData = jsonEncode(getProfileResponse.toJson());
    await box.write(profileKey, encodedData);
    return unit;
  }

  @override
  Future<String> getRole() {
    final userData = box.read<Map<String, dynamic>?>(userKey);

    return Future.value((userData?['role'] ?? '') as String);
  }

  @override
  Future<String> getEmail() {
    final userData = box.read<Map<String, dynamic>?>(userKey);

    return Future.value((userData?['email'] ?? '') as String);
  }

  @override
  Future<GetProfileResponseLocal> getProfile() async {
    final data = box.read<Map<String, dynamic>>(userKey);

    if (data is! Map) {
      return GetProfileResponseLocal();
    }

    return GetProfileResponseLocal.fromJson(
      Map<String, dynamic>.from(data!),
    );
  }

  @override
  Future<Unit> hasPaymentMethod() async {
    await box.write(hasPaymentMethodKey, true);
    return unit;
  }
}
