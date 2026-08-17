import 'package:json_annotation/json_annotation.dart';

part 'cancel_request.g.dart';

@JsonSerializable()
class CancelBookingRequest {
  const CancelBookingRequest({
    required this.id,
    required this.cancelReason,
  });

  Map<String, dynamic> toJson() => _$CancelBookingRequestToJson(this);

  @JsonKey(includeToJson: false)
  final int id;

  @JsonKey(name: 'cancel_reason')
  final String cancelReason;
}
