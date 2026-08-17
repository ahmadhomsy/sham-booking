import 'package:json_annotation/json_annotation.dart';

part 'find_one_response.g.dart';

@JsonSerializable(explicitToJson: true)
class FindOneResponse {
  FindOneResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory FindOneResponse.fromJson(Map<String, dynamic> json) =>
      _$FindOneResponseFromJson(json);
  final int? statusCode;
  final String? message;
  final BookingData? data;
  Map<String, dynamic> toJson() => _$FindOneResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookingData {
  BookingData({
    this.id,
    this.checkIn,
    this.checkOut,
    this.status,
    this.nights,
    this.guestName,
    this.guestPhone,
    this.pricePerNight,
    this.taxes,
    this.discount,
    this.totalPrice,
    this.notes,
    this.cancelReason,
    this.checkedInAt,
    this.checkedOutAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
    this.room,
    this.hotel,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) =>
      _$BookingDataFromJson(json);
  final int? id;
  @JsonKey(name: 'check_in')
  final String? checkIn;
  @JsonKey(name: 'check_out')
  final String? checkOut;
  final String? status;
  final int? nights;
  @JsonKey(name: 'guest_name')
  final String? guestName;
  @JsonKey(name: 'guest_phone')
  final String? guestPhone;
  @JsonKey(name: 'price_per_night')
  final String? pricePerNight;
  final String? taxes;
  final String? discount;
  @JsonKey(name: 'total_price')
  final String? totalPrice;
  final String? notes;
  @JsonKey(name: 'cancel_reason')
  final String? cancelReason;
  @JsonKey(name: 'checked_in_at')
  final String? checkedInAt;
  @JsonKey(name: 'checked_out_at')
  final String? checkedOutAt;
  final dynamic updatedAt;
  final dynamic deletedAt;
  final User? user;
  final Room? room;
  final Hotel? hotel;
  Map<String, dynamic> toJson() => _$BookingDataToJson(this);
}

@JsonSerializable()
class User {
  User({
    this.id,
    this.fullName,
    this.email,
    this.role,
    this.phone,
    this.nationality,
    this.stripeCustomerId,
    this.paymentMethodId,
    this.paypalVaultId,
    this.paypalEmail,
    this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  final int? id;
  @JsonKey(name: 'full_name')
  final String? fullName;
  final String? email;
  final String? role;
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
  final bool? isVerified;
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Room {
  Room({
    this.id,
    this.roomNumber,
    this.status,
    this.type,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  final int? id;
  @JsonKey(name: 'room_number')
  final String? roomNumber;
  final String? status;
  final RoomType? type;
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}

@JsonSerializable()
class RoomType {
  RoomType({
    this.id,
    this.name,
    this.basePrice,
    this.images,
    this.amenities,
  });

  factory RoomType.fromJson(Map<String, dynamic> json) =>
      _$RoomTypeFromJson(json);
  final int? id;
  final String? name;
  @JsonKey(name: 'base_price')
  final String? basePrice;
  final List<String>? images;
  final List<String>? amenities;
  Map<String, dynamic> toJson() => _$RoomTypeToJson(this);
}

@JsonSerializable()
class Hotel {
  Hotel({
    this.id,
    this.name,
    this.address,
    this.rating,
    this.discount,
    this.description,
    this.logoImg,
    this.mainImg,
    this.images,
    this.videoUrl,
    this.mapLongitude,
    this.mapLatitude,
    this.phone,
    this.email,
    this.website,
    this.facebook,
    this.instagram,
    this.twitter,
    this.stripeAccountId,
    this.onboarded,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);
  final int? id;
  final String? name;
  final String? address;
  final String? rating;
  final String? discount;
  final String? description;
  @JsonKey(name: 'logo_img')
  final String? logoImg;
  @JsonKey(name: 'main_img')
  final String? mainImg;
  final List<String>? images;
  @JsonKey(name: 'video_url')
  final String? videoUrl;
  @JsonKey(name: 'map_longitude')
  final String? mapLongitude;
  @JsonKey(name: 'map_latitude')
  final String? mapLatitude;
  final String? phone;
  final String? email;
  final String? website;
  final String? facebook;
  final String? instagram;
  final String? twitter;
  @JsonKey(name: 'stripe_account_id')
  final String? stripeAccountId;
  final bool? onboarded;
  Map<String, dynamic> toJson() => _$HotelToJson(this);
}
