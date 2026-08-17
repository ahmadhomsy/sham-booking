// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_hotels_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHotelsResponse _$GetHotelsResponseFromJson(Map<String, dynamic> json) =>
    GetHotelsResponse(
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => HotelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetHotelsResponseToJson(GetHotelsResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
