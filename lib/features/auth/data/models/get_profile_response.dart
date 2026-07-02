import 'package:json_annotation/json_annotation.dart';
part 'get_profile_response.g.dart';

@JsonSerializable()
class GetProfileResponse {
  GetProfileResponse({this.message, this.userProfileData, this.statusCode});
  factory GetProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetProfileResponseToJson(this);
  String? message;
  int? statusCode;
  @JsonKey(name: 'data')
  UserProfileData? userProfileData;
}

@JsonSerializable()
class UserProfileData {
  UserProfileData({
    this.phone,
    this.email,
    this.hotel,
    this.id,
    this.isVerified,
    this.name,
    this.nationality,
    this.role,
    this.stripeAccountId,
    this.stripeCustomerId,
    this.paypalVaultId,
  });
  factory UserProfileData.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileDataToJson(this);
  int? id;
  @JsonKey(name: 'full_name')
  String? name;
  String? email;
  String? phone;
  String? nationality;
  String? role;
  @JsonKey(name: 'stripe_customer_id')
  String? stripeCustomerId;
  @JsonKey(name: 'stripe_account_id')
  String? stripeAccountId;
  @JsonKey(name: 'paypal_vault_id')
  String? paypalVaultId;
  @JsonKey(name: 'is_verified')
  bool? isVerified;
  String? hotel;
}
