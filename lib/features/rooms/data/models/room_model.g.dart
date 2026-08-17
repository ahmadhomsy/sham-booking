// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
  id: (json['id'] as num).toInt(),
  roomNumber: json['room_number'] as String,
  status: json['status'] as String,
  type: RoomTypeModel.fromJson(json['type'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
  'id': instance.id,
  'room_number': instance.roomNumber,
  'status': instance.status,
  'type': instance.type.toJson(),
};
