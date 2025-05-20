import 'package:dio/dio.dart';

import '../error/failure.dart';

class ExceptionMapper {
  static Failure fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Failure("Сервер не отвечает. Попробуйте позже.");

      case DioExceptionType.badResponse:
        final status = e.response?.statusCode ?? 0;
        final data = e.response?.data;

        String message = "Ошибка сервера ($status)";
        if (data is Map && data.containsKey('detail')) {
          message = data['detail'];
        } else if (data is Map && data.values.isNotEmpty) {
          message = data.values.first.toString();
        }

        return Failure(message, code: status);

      case DioExceptionType.cancel:
        return Failure("Запрос был отменён.");

      case DioExceptionType.unknown:
        return Failure("Что-то пошло не так. Проверьте интернет-соединение.");

      default:
        return Failure("Неизвестная ошибка.");
    }
  }

  static Failure from(Object error) {
    if (error is DioException) {
      return fromDioException(error);
    } else if (error is Failure) {
      return error;
    } else {
      return Failure("Непредвиденная ошибка: ${error.toString()}");
    }
  }
}
