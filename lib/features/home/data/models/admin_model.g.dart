// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminModel _$AdminModelFromJson(Map<String, dynamic> json) => AdminModel(
  id: (json['id'] as num).toInt(),
  fullName: json['full_name'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
  phone: json['phone'] as String,
  nationality: json['nationality'] as String,
  stripeCustomerId: json['stripe_customer_id'] as String?,
  paymentMethodId: json['payment_method_id'] as String?,
  paypalVaultId: json['paypal_vault_id'] as String?,
  paypalEmail: json['paypal_email'] as String?,
  isVerified: json['is_verified'] as bool,
);

Map<String, dynamic> _$AdminModelToJson(AdminModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'role': instance.role,
      'phone': instance.phone,
      'nationality': instance.nationality,
      'stripe_customer_id': instance.stripeCustomerId,
      'payment_method_id': instance.paymentMethodId,
      'paypal_vault_id': instance.paypalVaultId,
      'paypal_email': instance.paypalEmail,
      'is_verified': instance.isVerified,
    };
