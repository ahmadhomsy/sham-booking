import 'package:json_annotation/json_annotation.dart';
part 'sign_up_response.g.dart';

@JsonSerializable()
class SignUpResponse {
  SignUpResponse({this.message, this.userData, this.statusCode});
  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
  String? message;
  int? statusCode;
  @JsonKey(name: 'data')
  UserData? userData;
}

@JsonSerializable()
class UserData {
  UserData({this.userInfo, this.accessToken, this.refreshToken});
  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
  UserData copyWith({
    UserInfo? userInfo,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserData(
      userInfo: userInfo ?? this.userInfo,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @JsonKey(name: 'user')
  UserInfo? userInfo;
  @JsonKey(name: 'access_token')
  String? accessToken;
  @JsonKey(name: 'refresh_token')
  String? refreshToken;
}

@JsonSerializable()
class UserInfo {
  UserInfo({this.id, this.name, this.email, this.role});
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
  int? id;
  @JsonKey(name: 'full_name')
  String? name;
  String? email;
  String? role;
}
