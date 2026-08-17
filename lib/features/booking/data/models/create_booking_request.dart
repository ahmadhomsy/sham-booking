import 'package:json_annotation/json_annotation.dart';

part 'create_booking_request.g.dart';

@JsonSerializable()
class CreateBookingRequest {
  const CreateBookingRequest({
    required this.hotelId,
    required this.roomId,
    required this.checkIn,
    required this.checkOut,
    required this.guestName,
    required this.guestPhone,
    required this.notes,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() => _$CreateBookingRequestToJson(this);

  @JsonKey(name: 'hotel_id')
  final int hotelId;

  @JsonKey(name: 'room_id')
  final int roomId;

  @JsonKey(name: 'check_in')
  final String checkIn;

  @JsonKey(name: 'check_out')
  final String checkOut;

  @JsonKey(name: 'guest_name')
  final String guestName;

  @JsonKey(name: 'guest_phone')
  final String guestPhone;

  final String notes;

  @JsonKey(name: 'payment_method')
  final String paymentMethod;
}
