// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_user_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInUserRequestModel _$SignInUserRequestModelFromJson(
  Map<String, dynamic> json,
) => SignInUserRequestModel(
  password: json['password'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$SignInUserRequestModelToJson(
  SignInUserRequestModel instance,
) => <String, dynamic>{'password': instance.password, 'email': instance.email};
