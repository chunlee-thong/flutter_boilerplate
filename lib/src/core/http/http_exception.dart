import 'package:dio/dio.dart';

abstract class HttpRequestException {}

class HttpErrorMessage {
  static const unexpectedError = "An unexpected error occur!";
  static const internalServerError = "Internal server error. Please try again later!";
  static const unexpectedTypeError = "An unexpected type error occur!";
  static const connectionError =
      "Error connecting to server. Please check your internet connection or Try again later!";
  static const timeoutError = "Connection timeout. Please check your internet connection or Try again later!";
}

class DioErrorException extends HttpRequestException {
  final int? statusCode;
  final String message;
  final bool _timeout;

  DioErrorException(this.message, {this.statusCode}) : _timeout = false;

  DioErrorException.timeout()
      : _timeout = true,
        statusCode = null,
        message = HttpErrorMessage.timeoutError;

  bool get isTimeOut => _timeout;

  factory DioErrorException.response(Response? response) {
    if (response == null) {
      return DioErrorException("Invalid response");
    }
    String errorMessage;
    int statusCode = response.statusCode ?? 500;

    if (statusCode >= 500) {
      errorMessage = HttpErrorMessage.internalServerError;
    } else if (response.data is Map) {
      errorMessage = response.data["message"] ?? HttpErrorMessage.unexpectedError;
    } else {
      errorMessage = HttpErrorMessage.unexpectedTypeError;
    }
    return DioErrorException(errorMessage, statusCode: statusCode);
  }

  //
  @override
  String toString() => message;
}

class NoInternetException extends HttpRequestException {
  @override
  String toString() {
    return HttpErrorMessage.connectionError;
  }
}

class RequestCancelException extends HttpRequestException {
  @override
  String toString() {
    return "Cancel the http request via cancel token";
  }
}

class SessionExpiredException extends HttpRequestException {
  static const int code = 420;

  final String message = "Session expired, Please login again";
  @override
  String toString() {
    return "Session expired, Please login again";
  }
}
