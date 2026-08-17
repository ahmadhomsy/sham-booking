// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookingResponse _$GetBookingResponseFromJson(Map<String, dynamic> json) =>
    GetBookingResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetBookingResponseToJson(GetBookingResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

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
  user: BookingUserModel.fromJson(json['user'] as Map<String, dynamic>),
  room: BookingRoomModel.fromJson(json['room'] as Map<String, dynamic>),
  hotel: BookingHotelModel.fromJson(json['hotel'] as Map<String, dynamic>),
  notes: json['notes'] as String?,
  cancelReason: json['cancel_reason'] as String?,
  checkedInAt: json['checked_in_at'] as String?,
  checkedOutAt: json['checked_out_at'] as String?,
  updatedAt: json['updatedAt'],
  deletedAt: json['deletedAt'] as String?,
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
      'user': instance.user.toJson(),
      'room': instance.room.toJson(),
      'hotel': instance.hotel.toJson(),
    };

BookingUserModel _$BookingUserModelFromJson(Map<String, dynamic> json) =>
    BookingUserModel(
      id: (json['id'] as num).toInt(),
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      phone: json['phone'] as String?,
      nationality: json['nationality'] as String?,
      stripeCustomerId: json['stripe_customer_id'] as String?,
      paymentMethodId: json['payment_method_id'] as String?,
      paypalVaultId: json['paypal_vault_id'] as String?,
      paypalEmail: json['paypal_email'] as String?,
      isVerified: json['is_verified'] as bool,
    );

Map<String, dynamic> _$BookingUserModelToJson(BookingUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'role': instance.role,
      'phone': instance.phone,
      'nationality': instance.nationality,
      'stripe_customer_id': instance.stripeCustomerId,
      'payment_method_id': instance.paymentMethodId,
      'paypal_vault_id': instance.paypalVaultId,
      'paypal_email': instance.paypalEmail,
      'is_verified': instance.isVerified,
    };

BookingRoomModel _$BookingRoomModelFromJson(Map<String, dynamic> json) =>
    BookingRoomModel(
      id: (json['id'] as num).toInt(),
      roomNumber: json['room_number'] as String,
      status: json['status'] as String,
      type: BookingRoomTypeModel.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingRoomModelToJson(BookingRoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'room_number': instance.roomNumber,
      'status': instance.status,
      'type': instance.type.toJson(),
    };

BookingRoomTypeModel _$BookingRoomTypeModelFromJson(
  Map<String, dynamic> json,
) => BookingRoomTypeModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  basePrice: json['base_price'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  amenities: (json['amenities'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$BookingRoomTypeModelToJson(
  BookingRoomTypeModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'base_price': instance.basePrice,
  'images': instance.images,
  'amenities': instance.amenities,
};

BookingHotelModel _$BookingHotelModelFromJson(Map<String, dynamic> json) =>
    BookingHotelModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      address: json['address'] as String,
      rating: json['rating'] as String,
      discount: json['discount'] as String,
      description: json['description'] as String,
      logoImg: json['logo_img'] as String,
      mainImg: json['main_img'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      mapLongitude: json['map_longitude'] as String,
      mapLatitude: json['map_latitude'] as String,
      onboarded: json['onboarded'] as bool,
      videoUrl: json['video_url'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      twitter: json['twitter'] as String?,
      stripeAccountId: json['stripe_account_id'] as String?,
    );

Map<String, dynamic> _$BookingHotelModelToJson(BookingHotelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'rating': instance.rating,
      'discount': instance.discount,
      'description': instance.description,
      'logo_img': instance.logoImg,
      'main_img': instance.mainImg,
      'images': instance.images,
      'video_url': instance.videoUrl,
      'map_longitude': instance.mapLongitude,
      'map_latitude': instance.mapLatitude,
      'phone': instance.phone,
      'email': instance.email,
      'website': instance.website,
      'facebook': instance.facebook,
      'instagram': instance.instagram,
      'twitter': instance.twitter,
      'stripe_account_id': instance.stripeAccountId,
      'onboarded': instance.onboarded,
    };
