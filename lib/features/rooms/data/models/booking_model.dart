import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel {
  const BookingModel({
    required this.id,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.nights,
    required this.guestName,
    required this.guestPhone,
    required this.pricePerNight,
    required this.taxes,
    required this.discount,
    required this.totalPrice,
    this.notes,
    this.cancelReason,
    this.checkedInAt,
    this.checkedOutAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);

  final int id;

  @JsonKey(name: 'check_in')
  final String checkIn;

  @JsonKey(name: 'check_out')
  final String checkOut;

  final String status;

  final int nights;

  @JsonKey(name: 'guest_name')
  final String guestName;

  @JsonKey(name: 'guest_phone')
  final String guestPhone;

  @JsonKey(name: 'price_per_night')
  final String pricePerNight;

  final String taxes;

  final String discount;

  @JsonKey(name: 'total_price')
  final String totalPrice;

  final String? notes;

  @JsonKey(name: 'cancel_reason')
  final String? cancelReason;

  @JsonKey(name: 'checked_in_at')
  final String? checkedInAt;

  @JsonKey(name: 'checked_out_at')
  final String? checkedOutAt;

  final dynamic updatedAt;

  final dynamic deletedAt;
}
