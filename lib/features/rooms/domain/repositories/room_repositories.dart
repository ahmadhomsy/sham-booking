import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/rooms/data/models/get_available_room_response.dart';
import 'package:sham_booking/features/rooms/data/models/get_hotel_room_response.dart';
import 'package:sham_booking/features/rooms/data/models/get_room_response.dart';
import 'package:sham_booking/features/rooms/data/models/show_room_response.dart';

abstract class RoomRepository {
  Future<Either<Failure, GetAvailableRoomResponse>> getAvailableRoom();
  Future<Either<Failure, GetRoomResponse>> getRoom(int id);
  Future<Either<Failure, ShowRoomResponse>> showRoom(int id);
  Future<Either<Failure, GetHotelRoomResponse>> getHotelRoom(int id);
}
