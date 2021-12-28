import 'package:dio/dio.dart';
import 'package:flutter_boiler_plate/src/constant/app_constant.dart';

abstract class HttpRequestException {}

class DioErrorException extends HttpRequestException {
  final int? code;
  final String message;

  DioErrorException(this.message, {this.code});

  factory DioErrorException.response(Response response) {
    String errorMessage;
    int statusCode = response.statusCode ?? 500;

    if (statusCode >= 500) {
      errorMessage = ErrorMessage.INTERNAL_SERVER_ERROR;
    } else if (response.data is Map) {
      errorMessage = response.data["message"] ?? ErrorMessage.UNEXPECTED_ERROR;
    } else {
      errorMessage = ErrorMessage.UNEXPECTED_ERROR;
    }
    return DioErrorException(errorMessage, code: statusCode);
  }

  //
  @override
  String toString() {
    return code != null ? "$code: $message" : message;
  }
}

class SessionExpiredException extends HttpRequestException {
  static const int code = 420;
  @override
  String toString() {
    return "Session expired, Please login again";
  }
}

///A custom exception class to handle [Error] type in Http request
///Because TypeError doesn't allow to override message
///This class provide a custom message and stackTrace
class HttpRequestErrorWrapper {
  final String message;
  final dynamic stackTrace;

  HttpRequestErrorWrapper(this.message, [this.stackTrace]);

  @override
  String toString() {
    return message;
  }
}
