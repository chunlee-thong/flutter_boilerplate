import 'package:dio/dio.dart';

abstract class HttpRequestException {}

class HttpErrorMessage {
  HttpErrorMessage._();
  static const String UNEXPECTED_ERROR = "An unexpected error occur!";
  static const String INTERNAL_SERVER_ERROR = "Internal server error, Please try again later.";
  static const String UNEXPECTED_TYPE_ERROR = "An unexpected type error occur!";
  static const String CONNECTION_ERROR =
      "Error connecting to server. Please check your internet connection or Try again later!";
  static const String TIMEOUT_ERROR = "Connection timeout. Please check your internet connection or Try again later!";
}

class DioErrorException extends HttpRequestException {
  final int? code;
  final String message;

  DioErrorException(this.message, {this.code});

  factory DioErrorException.response(Response? response) {
    if (response == null) {
      return DioErrorException("Invalid response");
    }
    String errorMessage;
    int statusCode = response.statusCode ?? 500;

    if (statusCode >= 500) {
      errorMessage = HttpErrorMessage.INTERNAL_SERVER_ERROR;
    } else if (response.data is Map) {
      errorMessage = response.data["message"] ?? HttpErrorMessage.UNEXPECTED_ERROR;
    } else {
      errorMessage = HttpErrorMessage.UNEXPECTED_ERROR;
    }
    return DioErrorException(errorMessage, code: statusCode);
  }

  //
  @override
  String toString() {
    return message;
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
