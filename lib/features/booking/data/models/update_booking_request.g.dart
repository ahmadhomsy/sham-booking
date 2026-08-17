// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_booking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBookingRequest _$UpdateBookingRequestFromJson(
  Map<String, dynamic> json,
) => UpdateBookingRequest(
  id: (json['id'] as num).toInt(),
  checkIn: json['check_in'] as String,
  checkOut: json['check_out'] as String,
  guestName: json['guest_name'] as String,
  guestPhone: json['guest_phone'] as String,
  notes: json['notes'] as String,
);

Map<String, dynamic> _$UpdateBookingRequestToJson(
  UpdateBookingRequest instance,
) => <String, dynamic>{
  'check_in': instance.checkIn,
  'check_out': instance.checkOut,
  'guest_name': instance.guestName,
  'guest_phone': instance.guestPhone,
  'notes': instance.notes,
};
