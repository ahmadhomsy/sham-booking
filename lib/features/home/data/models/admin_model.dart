import 'package:json_annotation/json_annotation.dart';

part 'admin_model.g.dart';

@JsonSerializable()
class AdminModel {
  const AdminModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.phone,
    required this.nationality,
    required this.isVerified,
    this.stripeCustomerId,
    this.paymentMethodId,
    this.paypalVaultId,
    this.paypalEmail,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) =>
      _$AdminModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminModelToJson(this);

  final int id;

  @JsonKey(name: 'full_name')
  final String fullName;

  final String email;
  final String role;
  final String phone;
  final String nationality;

  @JsonKey(name: 'stripe_customer_id')
  final String? stripeCustomerId;

  @JsonKey(name: 'payment_method_id')
  final String? paymentMethodId;

  @JsonKey(name: 'paypal_vault_id')
  final String? paypalVaultId;

  @JsonKey(name: 'paypal_email')
  final String? paypalEmail;

  @JsonKey(name: 'is_verified')
  final bool isVerified;
}
