import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';
import 'package:sham_booking/features/rooms/data/models/show_room_response.dart';
import 'package:sham_booking/features/rooms/domain/repositories/room_repositories.dart';

class ShowRoomUseCase {
  ShowRoomUseCase(this.repository);
  final RoomRepository repository;

  Future<Either<Failure, ShowRoomResponse>> call(int id) {
    return repository.showRoom(id);
  }
}
