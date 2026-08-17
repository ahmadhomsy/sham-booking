import 'package:json_annotation/json_annotation.dart';

import 'package:sham_booking/features/home/data/models/hotel_model.dart';

part 'get_hotel_details_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetHotelDetailsResponse {
  const GetHotelDetailsResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetHotelDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetHotelDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetHotelDetailsResponseToJson(this);

  final int statusCode;
  final String message;
  final HotelModel data;
}
