import 'package:json_annotation/json_annotation.dart';
import 'package:sham_booking/features/rooms/data/models/room_model.dart';

part 'get_room_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetRoomResponse {
  const GetRoomResponse({
    required this.data,
    this.statusCode,
    this.message,
  });

  factory GetRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$GetRoomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetRoomResponseToJson(this);

  final int? statusCode;
  final String? message;
  final List<RoomModel> data;
}
