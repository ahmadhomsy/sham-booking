import 'package:sham_booking/core/api/api_consumer.dart';
import 'package:sham_booking/core/api/end_points.dart';
import 'package:sham_booking/features/home/data/models/get_hotel_details_response.dart';
import 'package:sham_booking/features/home/data/models/get_hotels_response.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';

abstract class HotelRemoteDataSource {
  Future<List<HotelModel>> getAllHotels();
  Future<HotelModel> getHotelDetails(int id);
}

class HotelRemoteDataSourceImpl implements HotelRemoteDataSource {
  HotelRemoteDataSourceImpl(this.apiConsumer);
  final ApiConsumer apiConsumer;
  @override
  Future<List<HotelModel>> getAllHotels() async {
    final response = await apiConsumer.get(EndPoints.getAllHotels);


    final result = GetHotelsResponse.fromJson(
      response as Map<String, dynamic>,
    );

    return result.data;
  }

  @override
  Future<HotelModel> getHotelDetails(int id) async {
    final response = await apiConsumer.get(
      EndPoints.getHotelDetails(id),
    );

    return GetHotelDetailsResponse.fromJson(
      response as Map<String, dynamic>,
    ).data;
  }
}
