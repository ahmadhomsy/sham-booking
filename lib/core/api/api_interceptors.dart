import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sham_booking/core/api/end_points.dart';
import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';

class ApiInterceptors extends Interceptor {
  ApiInterceptors(this.secureStorage);

  final FlutterSecureStorage secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept'] = 'application/json';
    final lang = box.read<String>(enLangKey);
    options.headers['Accept-Language'] = lang ?? 'en';
    final accessToken = await secureStorage.read(
      key: accessTokenKey,
    );
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await secureStorage.read(
        key: refreshTokenKey,
      );
      if (refreshToken != null) {
        final dio = Dio();
        try {
          final response = await dio.post(
            '${EndPoints.baseUrl}${EndPoints.refreshToken}',
            data: {'refreshToken': refreshToken},
          );
          if (response.statusCode == 200) {
            final newAccessToken = response.data['accessToken'] as String;
            final newRefreshToken = response.data['refreshToken'] as String;
            await secureStorage.write(
              key: accessTokenKey,
              value: newAccessToken,
            );

            await secureStorage.write(
              key: refreshTokenKey,
              value: newRefreshToken,
            );

            err.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';
            final retryResponse = await dio.fetch(err.requestOptions);
            return handler.resolve(retryResponse);
          }
        } catch (e) {
          // Token refresh failed. Handle logout if necessary.
          await secureStorage.delete(key: accessTokenKey);
          await secureStorage.delete(key: refreshTokenKey);
        }
      }
    }
    super.onError(err, handler);
  }
}
