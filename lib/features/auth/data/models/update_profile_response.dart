import 'package:json_annotation/json_annotation.dart';
part 'update_profile_response.g.dart';

@JsonSerializable()
class UpdateProfileResponse {
  UpdateProfileResponse({
    this.message,
    this.updateProfileData,
    this.statusCode,
  });
  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileResponseFromJson(json);
  String? message;
  int? statusCode;
  @JsonKey(name: 'data')
  UpdateProfileData? updateProfileData;
}

@JsonSerializable()
class UpdateProfileData {
  UpdateProfileData({
    this.phone,
    this.email,
    this.hotel,
    this.id,
    this.isVerified,
    this.name,
    this.nationality,
    this.role,
    this.stripeCustomerId,
    this.paypalVaultId,
    this.paymentMethodId,
    this.paypalEmail,
    this.hashedRefreshToken,
    this.verificationCode,
    this.sendVerificationCodeAt,
  });
  factory UpdateProfileData.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileDataFromJson(json);
  int? id;
  @JsonKey(name: 'full_name')
  String? name;
  String? email;
  String? phone;
  String? nationality;
  String? role;
  String? hashedRefreshToken;
  @JsonKey(name: 'stripe_customer_id')
  String? stripeCustomerId;
  @JsonKey(name: 'payment_method_id')
  String? paymentMethodId;
  @JsonKey(name: 'paypal_vault_id')
  String? paypalVaultId;
  @JsonKey(name: 'paypal_email')
  String? paypalEmail;
  @JsonKey(name: 'is_verified')
  bool? isVerified;
  @JsonKey(name: 'verification_code')
  String? verificationCode;
  @JsonKey(name: 'send_verification_code_at')
  String? sendVerificationCodeAt;
  String? hotel;
}
