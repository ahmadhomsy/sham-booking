// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_hotel_room_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHotelRoomResponse _$GetHotelRoomResponseFromJson(
  Map<String, dynamic> json,
) => GetHotelRoomResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => HotelRoomModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  statusCode: (json['statusCode'] as num?)?.toInt(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$GetHotelRoomResponseToJson(
  GetHotelRoomResponse instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
};

HotelRoomModel _$HotelRoomModelFromJson(Map<String, dynamic> json) =>
    HotelRoomModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      basePrice: json['base_price'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      amenities: (json['amenities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      hotel: HotelModel.fromJson(json['hotel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HotelRoomModelToJson(HotelRoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'base_price': instance.basePrice,
      'images': instance.images,
      'amenities': instance.amenities,
      'hotel': instance.hotel,
    };
