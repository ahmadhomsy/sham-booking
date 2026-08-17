// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_hotel_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHotelDetailsResponse _$GetHotelDetailsResponseFromJson(
  Map<String, dynamic> json,
) => GetHotelDetailsResponse(
  statusCode: (json['statusCode'] as num).toInt(),
  message: json['message'] as String,
  data: HotelModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GetHotelDetailsResponseToJson(
  GetHotelDetailsResponse instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'message': instance.message,
  'data': instance.data.toJson(),
};
