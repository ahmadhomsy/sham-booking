import 'package:json_annotation/json_annotation.dart';

part 'physical_room_model.g.dart';

@JsonSerializable()
class PhysicalRoomModel {
  const PhysicalRoomModel({
    required this.id,
    required this.roomNumber,
    required this.status,
  });

  factory PhysicalRoomModel.fromJson(Map<String, dynamic> json) =>
      _$PhysicalRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhysicalRoomModelToJson(this);

  final int id;

  @JsonKey(name: 'room_number')
  final String roomNumber;

  final String status;
}
