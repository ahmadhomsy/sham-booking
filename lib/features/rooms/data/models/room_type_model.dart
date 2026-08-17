import 'package:json_annotation/json_annotation.dart';

part 'room_type_model.g.dart';

@JsonSerializable()
class RoomTypeModel {
  const RoomTypeModel({
    required this.id,
    required this.name,
    required this.basePrice,
    required this.images,
    required this.amenities,
  });

  factory RoomTypeModel.fromJson(Map<String, dynamic> json) =>
      _$RoomTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomTypeModelToJson(this);

  final int id;

  final String name;

  @JsonKey(name: 'base_price')
  final String basePrice;

  final List<String> images;

  final List<String> amenities;
}
