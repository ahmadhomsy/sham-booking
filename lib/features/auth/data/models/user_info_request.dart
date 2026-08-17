import 'package:json_annotation/json_annotation.dart';

part 'user_info_request.g.dart';

@JsonSerializable()
class UserInfoRequest {
  UserInfoRequest({
    this.id,
    this.paymentMethodId,
  });

  @JsonKey(includeToJson: false)
  int? id;

  @JsonKey(name: 'payment_method_id')
  String? paymentMethodId;

  Map<String, dynamic> toJson() => _$UserInfoRequestToJson(this);
}
