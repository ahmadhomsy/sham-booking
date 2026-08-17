import 'package:json_annotation/json_annotation.dart';
import 'package:sham_booking/features/rooms/data/models/room_type_model.dart';
part 'room_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RoomModel {
  const RoomModel({
    required this.id,
    required this.roomNumber,
    required this.status,
    required this.type,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  final int id;

  @JsonKey(name: 'room_number')
  final String roomNumber;

  final String status;

  final RoomTypeModel type;
}
