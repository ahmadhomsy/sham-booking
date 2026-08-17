import 'package:sham_booking/core/api/api_consumer.dart';
import 'package:sham_booking/core/api/end_points.dart';
import 'package:sham_booking/features/rooms/data/models/get_available_room_response.dart';
import 'package:sham_booking/features/rooms/data/models/get_hotel_room_response.dart';
import 'package:sham_booking/features/rooms/data/models/get_room_response.dart';
import 'package:sham_booking/features/rooms/data/models/show_room_response.dart';

abstract class RemoteRoomDataSource {
  Future<GetRoomResponse> getRoom(int id);
  Future<GetAvailableRoomResponse> getAvailableRoom();
  Future<ShowRoomResponse> showRoom(int id);
  Future<GetHotelRoomResponse> getHotelRoom(int id);
}

class RemoteRoomDataSourceImpl implements RemoteRoomDataSource {
  RemoteRoomDataSourceImpl(this.apiConsumer);
  final ApiConsumer apiConsumer;
  @override
  Future<GetRoomResponse> getRoom(int id) async {
    final response = await apiConsumer.get(EndPoints.getRoom);
    return GetRoomResponse.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<GetAvailableRoomResponse> getAvailableRoom() async {
    final response = await apiConsumer.get(
      EndPoints.getAvailableRooms,
    );
    return GetAvailableRoomResponse.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<ShowRoomResponse> showRoom(int id) async {
    final response = await apiConsumer.get(EndPoints.showRoom(id));
    return ShowRoomResponse.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<GetHotelRoomResponse> getHotelRoom(int id) async {
    final response = await apiConsumer.get(
      EndPoints.getHotelRoom,
      queryParameters: {
        'hotel_id': id,
      },
    );
    return GetHotelRoomResponse.fromJson(response as Map<String, dynamic>);
  }
}
