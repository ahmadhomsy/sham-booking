import 'package:json_annotation/json_annotation.dart';

import 'hotel_model.dart';

part 'get_hotels_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetHotelsResponse {
  const GetHotelsResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetHotelsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetHotelsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetHotelsResponseToJson(this);

  final int statusCode;
  final String message;
  final List<HotelModel> data;
}
