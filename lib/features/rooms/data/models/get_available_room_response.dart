import 'package:json_annotation/json_annotation.dart';
import 'package:sham_booking/features/rooms/data/models/physical_room_model.dart';

part 'get_available_room_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetAvailableRoomResponse {
  const GetAvailableRoomResponse({
    required this.data,
    this.statusCode,
    this.message,
  });

  factory GetAvailableRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAvailableRoomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAvailableRoomResponseToJson(this);

  final int? statusCode;
  final String? message;
  final List<AvailableRoomModel> data;
}

@JsonSerializable(explicitToJson: true)
class AvailableRoomModel {
  const AvailableRoomModel({
    required this.id,
    required this.name,
    required this.basePrice,
    required this.images,
    required this.amenities,
    required this.hotel,
    required this.totalAvailable,
    required this.physicalRooms,
  });

  factory AvailableRoomModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableRoomModelToJson(this);

  final int id;

  final String name;

  @JsonKey(name: 'base_price')
  final String basePrice;

  final List<String> images;

  final List<String> amenities;

  final AvailableHotelModel hotel;

  @JsonKey(name: 'total_available')
  final int totalAvailable;

  @JsonKey(name: 'physical_rooms')
  final List<PhysicalRoomModel> physicalRooms;
}

@JsonSerializable()
class AvailableHotelModel {
  const AvailableHotelModel({
    required this.id,
    required this.name,
  });

  factory AvailableHotelModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableHotelModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableHotelModelToJson(this);

  final int id;
  final String name;
}
