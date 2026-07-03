import 'package:json_annotation/json_annotation.dart';
part 'sign_in_user_request_model.g.dart';

@JsonSerializable()
class SignInUserRequestModel {
  const SignInUserRequestModel({
    required this.password,
    required this.email,
  });
  final String password;
  final String email;
  Map<String, dynamic> toJson() => _$SignInUserRequestModelToJson(this);
}
