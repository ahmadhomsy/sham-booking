// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_user_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpUserRequestModel _$SignUpUserRequestModelFromJson(
  Map<String, dynamic> json,
) => SignUpUserRequestModel(
  name: json['full_name'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  phone: json['phone'] as String?,
  nationality: json['nationality'] as String?,
);

Map<String, dynamic> _$SignUpUserRequestModelToJson(
  SignUpUserRequestModel instance,
) => <String, dynamic>{
  'full_name': instance.name,
  'email': instance.email,
  'password': instance.password,
  'phone': instance.phone,
  'nationality': instance.nationality,
};
