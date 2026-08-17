// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelBookingRequest _$CancelBookingRequestFromJson(
  Map<String, dynamic> json,
) => CancelBookingRequest(
  id: (json['id'] as num).toInt(),
  cancelReason: json['cancel_reason'] as String,
);

Map<String, dynamic> _$CancelBookingRequestToJson(
  CancelBookingRequest instance,
) => <String, dynamic>{'cancel_reason': instance.cancelReason};
