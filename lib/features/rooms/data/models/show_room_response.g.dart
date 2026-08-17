// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_room_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowRoomResponse _$ShowRoomResponseFromJson(Map<String, dynamic> json) =>
    ShowRoomResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : RoomData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowRoomResponseToJson(ShowRoomResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };

RoomData _$RoomDataFromJson(Map<String, dynamic> json) => RoomData(
  id: (json['id'] as num).toInt(),
  roomNumber: json['room_number'] as String,
  status: json['status'] as String,
  hotel: HotelModel.fromJson(json['hotel'] as Map<String, dynamic>),
  type: RoomTypeModel.fromJson(json['type'] as Map<String, dynamic>),
  bookings: (json['bookings'] as List<dynamic>)
      .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RoomDataToJson(RoomData instance) => <String, dynamic>{
  'id': instance.id,
  'room_number': instance.roomNumber,
  'status': instance.status,
  'hotel': instance.hotel.toJson(),
  'type': instance.type.toJson(),
  'bookings': instance.bookings.map((e) => e.toJson()).toList(),
};
