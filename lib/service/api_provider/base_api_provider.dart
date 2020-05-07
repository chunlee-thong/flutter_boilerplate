import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BaseApiProvider {
  final dio = Dio()
    ..options.baseUrl = ""
    ..options.connectTimeout = 20000
    ..options.receiveTimeout = 20000;

  final fss = FlutterSecureStorage();

  BaseApiProvider() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print("${options.method}: ${options.path}");
      return options;
    }, onResponse: (Response response) async {
      return response; // continue
    }, onError: (DioError error) async {
      print('Dio Error:' + error.message);
      return error; //continue
    }));
  }

  void handleExceptionError(dynamic error) {
    if (error is DioError) {
      String errorDescription = "Something went wrong.";
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription =
              "Connection timeout. Please check your internet connection";
          break;
        case DioErrorType.DEFAULT:
          errorDescription = "Connection failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Invalid status code: ${error.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send Connection timeout";
          break;
      }

      if (error.message.contains('SocketException')) {
        errorDescription = 'No internet connection!';
      }
      throw errorDescription;
    } else {
      throw "Something went wrong!";
    }
  }
}
