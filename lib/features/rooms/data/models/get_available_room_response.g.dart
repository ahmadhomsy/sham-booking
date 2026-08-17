// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_available_room_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAvailableRoomResponse _$GetAvailableRoomResponseFromJson(
  Map<String, dynamic> json,
) => GetAvailableRoomResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => AvailableRoomModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  statusCode: (json['statusCode'] as num?)?.toInt(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$GetAvailableRoomResponseToJson(
  GetAvailableRoomResponse instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
};

AvailableRoomModel _$AvailableRoomModelFromJson(
  Map<String, dynamic> json,
) => AvailableRoomModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  basePrice: json['base_price'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  amenities: (json['amenities'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  hotel: AvailableHotelModel.fromJson(json['hotel'] as Map<String, dynamic>),
  totalAvailable: (json['total_available'] as num).toInt(),
  physicalRooms: (json['physical_rooms'] as List<dynamic>)
      .map((e) => PhysicalRoomModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AvailableRoomModelToJson(AvailableRoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'base_price': instance.basePrice,
      'images': instance.images,
      'amenities': instance.amenities,
      'hotel': instance.hotel.toJson(),
      'total_available': instance.totalAvailable,
      'physical_rooms': instance.physicalRooms.map((e) => e.toJson()).toList(),
    };

AvailableHotelModel _$AvailableHotelModelFromJson(Map<String, dynamic> json) =>
    AvailableHotelModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$AvailableHotelModelToJson(
  AvailableHotelModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
