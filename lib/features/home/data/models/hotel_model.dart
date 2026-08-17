import 'package:json_annotation/json_annotation.dart';
import 'package:sham_booking/features/home/domain/entities/hotel_entity.dart';

import 'admin_model.dart';
import 'city_model.dart';

part 'hotel_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HotelModel {
  const HotelModel({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.discount,
    required this.description,
    required this.images,
    required this.mapLongitude,
    required this.mapLatitude,
    required this.phone,
    required this.email,
    required this.website,
    required this.facebook,
    required this.instagram,
    required this.twitter,
    required this.stripeAccountId,
    required this.onboarded,
    this.admins,
    this.city,
    this.logoImg,
    this.mainImg,
    this.videoUrl,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) =>
      _$HotelModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelModelToJson(this);

  final int id;
  final String name;
  final String address;
  final String rating;
  final String? discount;
  final String? description;

  @JsonKey(name: 'logo_img')
  final String? logoImg;

  @JsonKey(name: 'main_img')
  final String? mainImg;

  final List<String> images;

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

  final bool onboarded;

  final CityModel? city;

  final List<AdminModel>? admins;
}
