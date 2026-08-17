// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_one_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindOneResponse _$FindOneResponseFromJson(Map<String, dynamic> json) =>
    FindOneResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : BookingData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FindOneResponseToJson(FindOneResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };

BookingData _$BookingDataFromJson(Map<String, dynamic> json) => BookingData(
  id: (json['id'] as num?)?.toInt(),
  checkIn: json['check_in'] as String?,
  checkOut: json['check_out'] as String?,
  status: json['status'] as String?,
  nights: (json['nights'] as num?)?.toInt(),
  guestName: json['guest_name'] as String?,
  guestPhone: json['guest_phone'] as String?,
  pricePerNight: json['price_per_night'] as String?,
  taxes: json['taxes'] as String?,
  discount: json['discount'] as String?,
  totalPrice: json['total_price'] as String?,
  notes: json['notes'] as String?,
  cancelReason: json['cancel_reason'] as String?,
  checkedInAt: json['checked_in_at'] as String?,
  checkedOutAt: json['checked_out_at'] as String?,
  updatedAt: json['updatedAt'],
  deletedAt: json['deletedAt'],
  user: json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>),
  room: json['room'] == null
      ? null
      : Room.fromJson(json['room'] as Map<String, dynamic>),
  hotel: json['hotel'] == null
      ? null
      : Hotel.fromJson(json['hotel'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BookingDataToJson(BookingData instance) =>
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
      'user': instance.user?.toJson(),
      'room': instance.room?.toJson(),
      'hotel': instance.hotel?.toJson(),
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num?)?.toInt(),
  fullName: json['full_name'] as String?,
  email: json['email'] as String?,
  role: json['role'] as String?,
  phone: json['phone'] as String?,
  nationality: json['nationality'] as String?,
  stripeCustomerId: json['stripe_customer_id'] as String?,
  paymentMethodId: json['payment_method_id'] as String?,
  paypalVaultId: json['paypal_vault_id'] as String?,
  paypalEmail: json['paypal_email'] as String?,
  isVerified: json['is_verified'] as bool?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
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

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
  id: (json['id'] as num?)?.toInt(),
  roomNumber: json['room_number'] as String?,
  status: json['status'] as String?,
  type: json['type'] == null
      ? null
      : RoomType.fromJson(json['type'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
  'id': instance.id,
  'room_number': instance.roomNumber,
  'status': instance.status,
  'type': instance.type?.toJson(),
};

RoomType _$RoomTypeFromJson(Map<String, dynamic> json) => RoomType(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  basePrice: json['base_price'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  amenities: (json['amenities'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$RoomTypeToJson(RoomType instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'base_price': instance.basePrice,
  'images': instance.images,
  'amenities': instance.amenities,
};

Hotel _$HotelFromJson(Map<String, dynamic> json) => Hotel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  address: json['address'] as String?,
  rating: json['rating'] as String?,
  discount: json['discount'] as String?,
  description: json['description'] as String?,
  logoImg: json['logo_img'] as String?,
  mainImg: json['main_img'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  videoUrl: json['video_url'] as String?,
  mapLongitude: json['map_longitude'] as String?,
  mapLatitude: json['map_latitude'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  website: json['website'] as String?,
  facebook: json['facebook'] as String?,
  instagram: json['instagram'] as String?,
  twitter: json['twitter'] as String?,
  stripeAccountId: json['stripe_account_id'] as String?,
  onboarded: json['onboarded'] as bool?,
);

Map<String, dynamic> _$HotelToJson(Hotel instance) => <String, dynamic>{
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
