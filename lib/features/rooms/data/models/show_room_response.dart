import 'package:json_annotation/json_annotation.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';
import 'package:sham_booking/features/rooms/data/models/booking_model.dart';
import 'package:sham_booking/features/rooms/data/models/room_type_model.dart';

part 'show_room_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ShowRoomResponse {
  const ShowRoomResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory ShowRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$ShowRoomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShowRoomResponseToJson(this);

  final int? statusCode;
  final String? message;
  final RoomData? data;
}

@JsonSerializable(explicitToJson: true)
class RoomData {
  const RoomData({
    required this.id,
    required this.roomNumber,
    required this.status,
    required this.hotel,
    required this.type,
    required this.bookings,
  });

  factory RoomData.fromJson(Map<String, dynamic> json) =>
      _$RoomDataFromJson(json);

  Map<String, dynamic> toJson() => _$RoomDataToJson(this);

  final int id;

  @JsonKey(name: 'room_number')
  final String roomNumber;

  final String status;

  final HotelModel hotel;

  final RoomTypeModel type;

  final List<BookingModel> bookings;
}
