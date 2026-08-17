// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
  id: (json['id'] as num).toInt(),
  checkIn: json['check_in'] as String,
  checkOut: json['check_out'] as String,
  status: json['status'] as String,
  nights: (json['nights'] as num).toInt(),
  guestName: json['guest_name'] as String,
  guestPhone: json['guest_phone'] as String,
  pricePerNight: json['price_per_night'] as String,
  taxes: json['taxes'] as String,
  discount: json['discount'] as String,
  totalPrice: json['total_price'] as String,
  notes: json['notes'] as String?,
  cancelReason: json['cancel_reason'] as String?,
  checkedInAt: json['checked_in_at'] as String?,
  checkedOutAt: json['checked_out_at'] as String?,
  updatedAt: json['updatedAt'],
  deletedAt: json['deletedAt'],
);

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'check_in': instance.checkIn,
      'check_out': instance.checkOut,
      'status': instance.status,
      'nights': instance.nights,
      'guest_name': instance.guestName,
      'guest_phone': instance.guestPhone,
      'price_per_night': instance.pricePerNight,
      'taxes': instance.taxes,
      'discount': instance.discount,
      'total_price': instance.totalPrice,
      'notes': instance.notes,
      'cancel_reason': instance.cancelReason,
      'checked_in_at': instance.checkedInAt,
      'checked_out_at': instance.checkedOutAt,
      'updatedAt': instance.updatedAt,
      'deletedAt': instance.deletedAt,
    };
