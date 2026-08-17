import 'package:json_annotation/json_annotation.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';

part 'get_hotel_room_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetHotelRoomResponse {
  const GetHotelRoomResponse({
    required this.data,
    this.statusCode,
    this.message,
  });

  factory GetHotelRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$GetHotelRoomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetHotelRoomResponseToJson(this);

  final int? statusCode;
  final String? message;
  final List<HotelRoomModel> data;
}

@JsonSerializable()
class HotelRoomModel {
  const HotelRoomModel({
    required this.id,
    required this.name,
    required this.basePrice,
    required this.images,
    required this.amenities,
    required this.hotel,
  });

  factory HotelRoomModel.fromJson(Map<String, dynamic> json) =>
      _$HotelRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelRoomModelToJson(this);

  final int id;
  final String name;

  @JsonKey(name: 'base_price')
  final String basePrice;

  final List<String> images;
  final List<String> amenities;
  final HotelModel hotel;
}
