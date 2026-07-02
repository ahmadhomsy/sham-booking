// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoRequest _$UserInfoRequestFromJson(Map<String, dynamic> json) =>
    UserInfoRequest(
      name: json['full_name'] as String?,
      phone: json['phone'] as String?,
      nationality: json['nationality'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UserInfoRequestToJson(UserInfoRequest instance) =>
    <String, dynamic>{
      'full_name': instance.name,
      'phone': instance.phone,
      'nationality': instance.nationality,
      'password': instance.password,
    };
