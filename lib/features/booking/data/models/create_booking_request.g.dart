// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_booking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBookingRequest _$CreateBookingRequestFromJson(
  Map<String, dynamic> json,
) => CreateBookingRequest(
  hotelId: (json['hotel_id'] as num).toInt(),
  roomId: (json['room_id'] as num).toInt(),
  checkIn: json['check_in'] as String,
  checkOut: json['check_out'] as String,
  guestName: json['guest_name'] as String,
  guestPhone: json['guest_phone'] as String,
  notes: json['notes'] as String,
  paymentMethod: json['payment_method'] as String,
);

Map<String, dynamic> _$CreateBookingRequestToJson(
  CreateBookingRequest instance,
) => <String, dynamic>{
  'hotel_id': instance.hotelId,
  'room_id': instance.roomId,
  'check_in': instance.checkIn,
  'check_out': instance.checkOut,
  'guest_name': instance.guestName,
  'guest_phone': instance.guestPhone,
  'notes': instance.notes,
  'payment_method': instance.paymentMethod,
};
