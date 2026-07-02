// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileResponse _$UpdateProfileResponseFromJson(
  Map<String, dynamic> json,
) => UpdateProfileResponse(
  message: json['message'] as String?,
  updateProfileData: json['data'] == null
      ? null
      : UpdateProfileData.fromJson(json['data'] as Map<String, dynamic>),
  statusCode: (json['statusCode'] as num?)?.toInt(),
);

Map<String, dynamic> _$UpdateProfileResponseToJson(
  UpdateProfileResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'statusCode': instance.statusCode,
  'data': instance.updateProfileData,
};

UpdateProfileData _$UpdateProfileDataFromJson(Map<String, dynamic> json) =>
    UpdateProfileData(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      hotel: json['hotel'] as String?,
      id: (json['id'] as num?)?.toInt(),
      isVerified: json['is_verified'] as String?,
      name: json['full_name'] as String?,
      nationality: json['nationality'] as String?,
      role: json['role'] as String?,
      stripeCustomerId: json['stripe_customer_id'] as String?,
      paypalVaultId: json['paypal_vault_id'] as String?,
      paymentMethodId: json['payment_method_id'] as String?,
      paypalEmail: json['paypal_email'] as String?,
      hashedRefreshToken: json['hashedRefreshToken'] as String?,
      verificationCode: json['verification_code'] as String?,
      sendVerificationCodeAt: json['send_verification_code_at'] as String?,
    );

Map<String, dynamic> _$UpdateProfileDataToJson(UpdateProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'nationality': instance.nationality,
      'role': instance.role,
      'hashedRefreshToken': instance.hashedRefreshToken,
      'stripe_customer_id': instance.stripeCustomerId,
      'payment_method_id': instance.paymentMethodId,
      'paypal_vault_id': instance.paypalVaultId,
      'paypal_email': instance.paypalEmail,
      'is_verified': instance.isVerified,
      'verification_code': instance.verificationCode,
      'send_verification_code_at': instance.sendVerificationCodeAt,
      'hotel': instance.hotel,
    };
