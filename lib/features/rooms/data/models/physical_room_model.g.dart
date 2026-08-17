// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physical_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhysicalRoomModel _$PhysicalRoomModelFromJson(Map<String, dynamic> json) =>
    PhysicalRoomModel(
      id: (json['id'] as num).toInt(),
      roomNumber: json['room_number'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$PhysicalRoomModelToJson(PhysicalRoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'room_number': instance.roomNumber,
      'status': instance.status,
    };
