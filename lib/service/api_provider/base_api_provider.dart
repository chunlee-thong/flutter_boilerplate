import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_boiler_plate/constant/app_constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BaseApiProvider {
  final dio = Dio()
    ..options.baseUrl = AppConstant.BASE_URL
    ..options.connectTimeout = 20000
    ..options.receiveTimeout = 20000;

  final fss = FlutterSecureStorage();

  BaseApiProvider() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          print("${options.method}: ${options.path}");
          return options;
        },
        onResponse: (Response response) async {
          print("Http response => ${response.data}");
          return response; // continue
        },
        onError: (DioError error) async {
          print('Dio Error:' + error.message);
          return error; //continue
        },
      ),
    );

    dio.interceptors.add(
      DioCacheManager(
        CacheConfig(baseUrl: AppConstant.BASE_URL),
      ).interceptor,
    );
  }

  Future<T> onRequest<T>(Function onHttpRequest) async {
    try {
      return await onHttpRequest();
    } catch (exception) {
      throw handleExceptionError(exception);
    }
  }

  String handleExceptionError(dynamic error) {
    print("Exception caught: ${error.toString()}");
    String errorMessage = "An unexpected error occur!";
    //Dio Error
    if (error is DioError) {
      if (error.error is SocketException) {
        errorMessage =
            'Error connecting to server. Please check your internet connection or Try again later!';
      } else if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errorMessage =
            "Connection timeout. Please check your internet connection!";
      } else if (error.type == DioErrorType.RESPONSE) {
        errorMessage = "${error.response.statusCode}: $errorMessage";
      }
      return errorMessage;

      //Json convert error
    } else if (error is TypeError) {
      errorMessage = "Convertion error: $error";
      return errorMessage;
      //Error message from server
    } else {
      return error.toString();
    }
  }
}
