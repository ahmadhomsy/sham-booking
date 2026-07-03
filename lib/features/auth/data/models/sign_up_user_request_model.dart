import 'package:json_annotation/json_annotation.dart';
part 'sign_up_user_request_model.g.dart';

@JsonSerializable()
class SignUpUserRequestModel {
  const SignUpUserRequestModel({
    required this.name,
    required this.email,
    required this.password,
    this.phone,
    this.nationality,
  });
  @JsonKey(name: 'full_name')
  final String name;
  final String email;
  final String password;
  final String? phone;
  final String? nationality;

  Map<String, dynamic> toJson() => _$SignUpUserRequestModelToJson(this);
}
