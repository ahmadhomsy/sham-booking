import 'package:dartz/dartz.dart';
import 'package:sham_booking/core/api/api_consumer.dart';
import 'package:sham_booking/core/api/end_points.dart';
import 'package:sham_booking/features/booking/data/models/cancel_request.dart';
import 'package:sham_booking/features/booking/data/models/create_booking_request.dart';
import 'package:sham_booking/features/booking/data/models/find_one_response.dart';
import 'package:sham_booking/features/booking/data/models/get_booking_response.dart';
import 'package:sham_booking/features/booking/data/models/update_booking_request.dart';

abstract class RemoteBookingDataSource {
  Future<Unit> createBooking(CreateBookingRequest request);
  Future<Unit> updateBooking(UpdateBookingRequest request);
  Future<Unit> cancelBooking(CancelBookingRequest request);
  Future<Unit> deleteBooking(int id);
  Future<FindOneResponse> findOne(int id);
  Future<GetBookingResponse> getBooking();
}

class RemoteBookingDataSourceImpl implements RemoteBookingDataSource {
  RemoteBookingDataSourceImpl(this.apiConsumer);
  final ApiConsumer apiConsumer;

  @override
  Future<Unit> createBooking(CreateBookingRequest request) async {
    await apiConsumer.post(
      EndPoints.bookings,
      data: request.toJson(),
    );
    return unit;
  }

  @override
  Future<Unit> updateBooking(UpdateBookingRequest request) async {
    await apiConsumer.patch(
      '${EndPoints.bookings}/${request.id}',
      data: request.toJson(),
    );
    return unit;
  }

  @override
  Future<Unit> cancelBooking(CancelBookingRequest request) async {
    await apiConsumer.patch(
      '${EndPoints.bookings}/${request.id}/cancel', // أو عدّلها حسب الـ EndPoint لديك مثلاً: EndPoints.cancelBooking
      data: request.toJson(),
    );
    return unit;
  }

  @override
  Future<Unit> deleteBooking(int id) async {
    await apiConsumer.delete(
      '${EndPoints.bookings}/$id',
    );
    return unit;
  }

  @override
  Future<FindOneResponse> findOne(int id) async {
    final response = await apiConsumer.get(
      '${EndPoints.bookings}/$id',
    );
    return FindOneResponse.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<GetBookingResponse> getBooking() async {
    final response = await apiConsumer.get(
      EndPoints.bookings,
    );
    return GetBookingResponse.fromJson(response as Map<String, dynamic>);
  }
}
