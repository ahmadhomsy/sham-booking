import 'package:json_annotation/json_annotation.dart';

part 'update_booking_request.g.dart';

@JsonSerializable()
class UpdateBookingRequest {
  const UpdateBookingRequest({
    required this.id,
    required this.checkIn,
    required this.checkOut,
    required this.guestName,
    required this.guestPhone,
    required this.notes,
  });

  Map<String, dynamic> toJson() => _$UpdateBookingRequestToJson(this);

  @JsonKey(name: 'check_in')
  final String checkIn;

  @JsonKey(name: 'check_out')
  final String checkOut;

  @JsonKey(name: 'guest_name')
  final String guestName;

  @JsonKey(name: 'guest_phone')
  final String guestPhone;

  final String notes;

  @JsonKey(includeToJson: false)
  final int id;
}
