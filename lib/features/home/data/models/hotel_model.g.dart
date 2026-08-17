// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelModel _$HotelModelFromJson(Map<String, dynamic> json) => HotelModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  address: json['address'] as String,
  rating: json['rating'] as String,
  discount: json['discount'] as String?,
  description: json['description'] as String?,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  mapLongitude: json['map_longitude'] as String?,
  mapLatitude: json['map_latitude'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  website: json['website'] as String?,
  facebook: json['facebook'] as String?,
  instagram: json['instagram'] as String?,
  twitter: json['twitter'] as String?,
  stripeAccountId: json['stripe_account_id'] as String?,
  onboarded: json['onboarded'] as bool,
  admins: (json['admins'] as List<dynamic>?)
      ?.map((e) => AdminModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  city: json['city'] == null
      ? null
      : CityModel.fromJson(json['city'] as Map<String, dynamic>),
  logoImg: json['logo_img'] as String?,
  mainImg: json['main_img'] as String?,
  videoUrl: json['video_url'] as String?,
);

Map<String, dynamic> _$HotelModelToJson(HotelModel instance) =>
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
      'city': instance.city?.toJson(),
      'admins': instance.admins?.map((e) => e.toJson()).toList(),
    };
