// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileResponse _$GetProfileResponseFromJson(Map<String, dynamic> json) =>
    GetProfileResponse(
      message: json['message'] as String?,
      userProfileData: json['data'] == null
          ? null
          : UserProfileData.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: (json['statusCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetProfileResponseToJson(GetProfileResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
      'data': instance.userProfileData,
    };

UserProfileData _$UserProfileDataFromJson(Map<String, dynamic> json) =>
    UserProfileData(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      hotel: json['hotel'] as String?,
      id: (json['id'] as num?)?.toInt(),
      isVerified: json['is_verified'] as bool?,
      name: json['full_name'] as String?,
      nationality: json['nationality'] as String?,
      role: json['role'] as String?,
      stripeAccountId: json['stripe_account_id'] as String?,
      stripeCustomerId: json['stripe_customer_id'] as String?,
      paypalVaultId: json['paypal_vault_id'] as String?,
    );

Map<String, dynamic> _$UserProfileDataToJson(UserProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'nationality': instance.nationality,
      'role': instance.role,
      'stripe_customer_id': instance.stripeCustomerId,
      'stripe_account_id': instance.stripeAccountId,
      'paypal_vault_id': instance.paypalVaultId,
      'is_verified': instance.isVerified,
      'hotel': instance.hotel,
    };
