abstract class HttpRequestException {}

class DioErrorException extends HttpRequestException {
  final int? code;
  final String message;

  DioErrorException(this.message, {this.code});
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
