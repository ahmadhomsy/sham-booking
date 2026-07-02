import 'package:json_annotation/json_annotation.dart';
part 'user_info_request.g.dart';

@JsonSerializable()
class UserInfoRequest {
  UserInfoRequest({
    this.name,
    this.phone,
    this.nationality,
    this.password,
  });
  Map<String, dynamic> toJson() => _$UserInfoRequestToJson(this);
  @JsonKey(name: 'full_name')
  String? name;
  String? phone;
  String? nationality;
  String? password;
}
