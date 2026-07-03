import 'package:dio/dio.dart';
import 'package:sham_booking/core/api/api_consumer.dart';
import 'package:sham_booking/core/api/api_interceptors.dart';
import 'package:sham_booking/core/api/end_points.dart';
import 'package:sham_booking/core/error/exceptions.dart';

class DioConsumer extends ApiConsumer {
  DioConsumer({required this.apiInterceptors, required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(apiInterceptors);
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        requestHeader: false,
      ),
    );
  }
  final ApiInterceptors apiInterceptors;

  final Dio dio;
  @override
  Future<dynamic> delete(String url) async {
    try {
      final response = await dio.delete(
        url,
      );
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future<dynamic> post(String url, {data}) async {
    try {
      final response = await dio.post(
        url,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future<dynamic> put(String url, {data}) async {
    try {
      final response = await dio.put(url, data: data);
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future<dynamic> patch(
    String url, {
    dynamic data,
  }) async {
    try {
      final response = await dio.patch(
        url,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }
}
