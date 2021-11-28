class AppConstant {}

class ErrorMessage {
  ErrorMessage._();
  static const String UNEXPECTED_ERROR = "An unexpected error occur!";
  static const String INTERNAL_SERVER_ERROR = "Internal server error, Please try again later.";
  static const String UNEXPECTED_TYPE_ERROR = "An unexpected type error occur!";
  static const String CONNECTION_ERROR =
      "Error connecting to server. Please check your internet connection or Try again later!";
  static const String TIMEOUT_ERROR = "Connection timeout. Please check your internet connection or Try again later!";
}

class HttpMethod {
  HttpMethod._();

  static const String GET = "get";
  static const String POST = "post";
  static const String PATCH = "patch";
  static const String PUT = "put";
  static const String DELETE = "delete";
}
