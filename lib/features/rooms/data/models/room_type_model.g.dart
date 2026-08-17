// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomTypeModel _$RoomTypeModelFromJson(Map<String, dynamic> json) =>
    RoomTypeModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      basePrice: json['base_price'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      amenities: (json['amenities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RoomTypeModelToJson(RoomTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'base_price': instance.basePrice,
      'images': instance.images,
      'amenities': instance.amenities,
    };
