// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoRequest _$UserInfoRequestFromJson(Map<String, dynamic> json) =>
    UserInfoRequest(
      id: (json['id'] as num?)?.toInt(),
      paymentMethodId: json['payment_method_id'] as String?,
    );

Map<String, dynamic> _$UserInfoRequestToJson(UserInfoRequest instance) =>
    <String, dynamic>{'payment_method_id': instance.paymentMethodId};
