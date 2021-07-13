import '../api/client/http_exception.dart';

class UserCancelException {
  @override
  String toString() {
    return "User cancel operation, No need to do anything";
  }
}

class SessionExpiredException extends BaseHttpException {
  static final int code = 420;
  @override
  String toString() {
    return "Session expired, Please login again";
  }
}

class CustomErrorWrapper {
  final String message;
  final dynamic stackTrace;

  ///A custom exception class to handle [Error] type in Http request
  ///Because TypeError doesn't allow to override message
  ///This class provide a custom message and stackTrace
  CustomErrorWrapper(this.message, this.stackTrace);

  @override
  String toString() {
    return message;
  }
}
