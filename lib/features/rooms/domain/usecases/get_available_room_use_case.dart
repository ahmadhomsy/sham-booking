import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/rooms/data/models/get_available_room_response.dart';
import 'package:sham_booking/features/rooms/domain/repositories/room_repositories.dart';

class GetAvailableRoomUseCase {
  GetAvailableRoomUseCase(this.repositories);
  final RoomRepository repositories;
  Future<Either<Failure, GetAvailableRoomResponse>> call() {
    return repositories.getAvailableRoom();
  }
}
