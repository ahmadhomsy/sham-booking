// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_room_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRoomResponse _$GetRoomResponseFromJson(Map<String, dynamic> json) =>
    GetRoomResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => RoomModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetRoomResponseToJson(GetRoomResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
