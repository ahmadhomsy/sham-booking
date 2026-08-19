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
          final response = await dio.post<dynamic>(
            '${EndPoints.baseUrl}${EndPoints.refreshToken}',
            data: {
              'refresh_token': refreshToken,
              'refreshToken': refreshToken,
            },
          );
          if (response.statusCode == 200 || response.statusCode == 201) {
            final rawData = response.data;
            final dataMap = (rawData is Map<String, dynamic>)
                ? ((rawData['data'] is Map<String, dynamic>)
                      ? rawData['data'] as Map<String, dynamic>
                      : rawData)
                : <String, dynamic>{};

            final newAccessToken =
                (dataMap['access_token'] ?? dataMap['accessToken'])?.toString();
            final newRefreshToken =
                (dataMap['refresh_token'] ?? dataMap['refreshToken'])
                    ?.toString();

            if (newAccessToken != null && newAccessToken.isNotEmpty) {
              await secureStorage.write(
                key: accessTokenKey,
                value: newAccessToken,
              );

              if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
                await secureStorage.write(
                  key: refreshTokenKey,
                  value: newRefreshToken,
                );
              }

              err.requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';
              final retryResponse = await dio.fetch<dynamic>(
                err.requestOptions,
              );
              return handler.resolve(retryResponse);
            }
          }
        } on Exception catch (_) {
          // Token refresh failed. Clear tokens.
          await secureStorage.delete(key: accessTokenKey);
          await secureStorage.delete(key: refreshTokenKey);
        }
      }
    }
    super.onError(err, handler);
  }
}
