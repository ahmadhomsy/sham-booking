import 'package:json_annotation/json_annotation.dart';
part 'get_profile_response_local.g.dart';

@JsonSerializable()
class GetProfileResponseLocal {
  GetProfileResponseLocal({this.name, this.email});
  factory GetProfileResponseLocal.fromJson(Map<String, dynamic> json) =>
      _$GetProfileResponseLocalFromJson(json);
  Map<String, dynamic> toJson() => _$GetProfileResponseLocalToJson(this);

  @JsonKey(name: 'full_name')
  String? name;
  String? email;
}
