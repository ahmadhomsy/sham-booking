import 'package:json_annotation/json_annotation.dart';

part 'get_booking_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetBookingResponse {
  const GetBookingResponse({
    required this.data,
    this.statusCode,
    this.message,
  });

  factory GetBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBookingResponseToJson(this);

  final int? statusCode;
  final String? message;
  final List<BookingModel> data;
}

@JsonSerializable(explicitToJson: true)
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
    required this.user,
    required this.room,
    required this.hotel,
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

  final String? deletedAt;

  final BookingUserModel user;

  final BookingRoomModel room;

  final BookingHotelModel hotel;
}

@JsonSerializable()
class BookingUserModel {
  const BookingUserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.isVerified,
    this.phone,
    this.nationality,
    this.stripeCustomerId,
    this.paymentMethodId,
    this.paypalVaultId,
    this.paypalEmail,
  });

  factory BookingUserModel.fromJson(Map<String, dynamic> json) =>
      _$BookingUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingUserModelToJson(this);

  final int id;

  @JsonKey(name: 'full_name')
  final String fullName;

  final String email;

  final String role;

  final String? phone;

  final String? nationality;

  @JsonKey(name: 'stripe_customer_id')
  final String? stripeCustomerId;

  @JsonKey(name: 'payment_method_id')
  final String? paymentMethodId;

  @JsonKey(name: 'paypal_vault_id')
  final String? paypalVaultId;

  @JsonKey(name: 'paypal_email')
  final String? paypalEmail;

  @JsonKey(name: 'is_verified')
  final bool isVerified;
}

@JsonSerializable(explicitToJson: true)
class BookingRoomModel {
  const BookingRoomModel({
    required this.id,
    required this.roomNumber,
    required this.status,
    required this.type,
  });

  factory BookingRoomModel.fromJson(Map<String, dynamic> json) =>
      _$BookingRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingRoomModelToJson(this);

  final int id;

  @JsonKey(name: 'room_number')
  final String roomNumber;

  final String status;

  final BookingRoomTypeModel type;
}

@JsonSerializable()
class BookingRoomTypeModel {
  const BookingRoomTypeModel({
    required this.id,
    required this.name,
    required this.basePrice,
    required this.images,
    required this.amenities,
  });

  factory BookingRoomTypeModel.fromJson(Map<String, dynamic> json) =>
      _$BookingRoomTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingRoomTypeModelToJson(this);

  final int id;

  final String name;

  @JsonKey(name: 'base_price')
  final String basePrice;

  final List<String> images;

  final List<String> amenities;
}

@JsonSerializable()
class BookingHotelModel {
  const BookingHotelModel({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.discount,
    required this.description,
    required this.logoImg,
    required this.mainImg,
    required this.images,
    required this.mapLongitude,
    required this.mapLatitude,
    required this.onboarded,
    this.videoUrl,
    this.phone,
    this.email,
    this.website,
    this.facebook,
    this.instagram,
    this.twitter,
    this.stripeAccountId,
  });

  factory BookingHotelModel.fromJson(Map<String, dynamic> json) =>
      _$BookingHotelModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingHotelModelToJson(this);

  final int id;

  final String name;

  final String address;

  final String rating;

  final String discount;

  final String description;

  @JsonKey(name: 'logo_img')
  final String logoImg;

  @JsonKey(name: 'main_img')
  final String mainImg;

  final List<String> images;

  @JsonKey(name: 'video_url')
  final String? videoUrl;

  @JsonKey(name: 'map_longitude')
  final String mapLongitude;

  @JsonKey(name: 'map_latitude')
  final String mapLatitude;

  final String? phone;

  final String? email;

  final String? website;

  final String? facebook;

  final String? instagram;

  final String? twitter;

  @JsonKey(name: 'stripe_account_id')
  final String? stripeAccountId;

  final bool onboarded;
}
