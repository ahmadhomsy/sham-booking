import 'package:dio/dio.dart';
import 'package:sham_booking/core/api/api_error_model.dart';

class WeakPasswordException implements Exception {}

class AlreadyRegisteredException implements Exception {}

class NotVerifiedException implements Exception {}

class IsFirstOpenException implements Exception {}

class TooManyRequestsException implements Exception {}

class OfflineException implements Exception {}

class EmptyCacheException implements Exception {}

class NotSignException implements Exception {}

class UnexpectedException implements Exception {}

class InvalidEmailException implements Exception {}

class ServerFailureException implements Exception {
  ServerFailureException({required this.errorModel});
  final ApiErrorModel errorModel;
}

Never handelDioException(DioException e) {
  if (e.response?.data != null) {
    throw ServerFailureException(
      errorModel: ApiErrorModel.fromJson(
        e.response!.data as Map<String, dynamic>,
      ),
    );
  }

  throw ServerFailureException(
    errorModel: ApiErrorModel(
      message: e.message ?? 'Network error',
      statusCode: e.response?.statusCode,
    ),
  );
}

// void handelDioException(DioException e) {
//   switch (e.type) {
//     case DioExceptionType.connectionTimeout:
//       throw ServerFailureException(
//         errorModel: ApiErrorModel.fromJson(
//           e.response!.data as Map<String, dynamic>,
//         ),
//       );
//     case DioExceptionType.sendTimeout:
//       throw ServerFailureException(
//         errorModel: ApiErrorModel.fromJson(
//           e.response!.data as Map<String, dynamic>,
//         ),
//       );
//     case DioExceptionType.receiveTimeout:
//       throw ServerFailureException(
//         errorModel: ApiErrorModel.fromJson(
//           e.response!.data as Map<String, dynamic>,
//         ),
//       );
//     case DioExceptionType.cancel:
//       throw ServerFailureException(
//         errorModel: ApiErrorModel.fromJson(
//           e.response!.data as Map<String, dynamic>,
//         ),
//       );
//     case DioExceptionType.unknown:
//       throw ServerFailureException(
//         errorModel: ApiErrorModel.fromJson(
//           e.response!.data as Map<String, dynamic>,
//         ),
//       );
//     case DioExceptionType.badCertificate:
//       throw ServerFailureException(
//         errorModel: ApiErrorModel.fromJson(
//           e.response!.data as Map<String, dynamic>,
//         ),
//       );
//     case DioExceptionType.connectionError:
//       throw ServerFailureException(
//         errorModel: ApiErrorModel.fromJson(
//           e.response!.data as Map<String, dynamic>,
//         ),
//       );
//     case DioExceptionType.badResponse:
//       switch (e.response?.statusCode) {
//         case 400:
//           throw ServerFailureException(
//             errorModel: ApiErrorModel.fromJson(
//               e.response!.data as Map<String, dynamic>,
//             ),
//           );
//         case 401:
//           throw ServerFailureException(
//             errorModel: ApiErrorModel.fromJson(
//               e.response!.data as Map<String, dynamic>,
//             ),
//           );
//         case 403:
//           throw ServerFailureException(
//             errorModel: ApiErrorModel.fromJson(
//               e.response!.data as Map<String, dynamic>,
//             ),
//           );
//         case 404:
//           throw ServerFailureException(
//             errorModel: ApiErrorModel.fromJson(
//               e.response!.data as Map<String, dynamic>,
//             ),
//           );
//         case 500:
//           throw ServerFailureException(
//             errorModel: ApiErrorModel.fromJson(
//               e.response!.data as Map<String, dynamic>,
//             ),
//           );
//       }
//   }
// }
