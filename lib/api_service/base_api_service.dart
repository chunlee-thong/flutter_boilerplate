import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import '../constant/app_constant.dart';
import 'base_http_exception.dart';

class BaseApiService {
  final dio = Dio()
    ..options.baseUrl = AppConstant.BASE_URL
    ..options.connectTimeout = 20000
    ..options.receiveTimeout = 20000;
  static JsonDecoder decoder = JsonDecoder();
  static JsonEncoder encoder = JsonEncoder.withIndent('  ');

  BaseApiService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          print("${options.method}: ${options.path},"
              "query: ${options.queryParameters},"
              "data: ${options.data}");
          return options;
        },
        onResponse: (Response response) async {
          //prettyPrintJson(response.data);
          return response; // continue
        },
        onError: (DioError error) async {
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

  void prettyPrintJson(dynamic input) {
    var prettyString = encoder.convert(input);
    prettyString.split('\n').forEach((element) => print(element));
  }

  Future<T> onRequest<T>(Function onHttpRequest) async {
    try {
      return await onHttpRequest();
    } on TypeError catch (exception) {
      onTypeError(exception);
      return null;
    } on DioError catch (exception) {
      onDioError(exception);
      return null;
    } catch (exception) {
      onServerErrorMessage(exception);
      return null;
    }
  }

  void onTypeError(dynamic exception) {
    print("Type error Stack trace: ${exception.stackTrace.toString()}");
    throw exception;
  }

  void onDioError(dynamic exception) {
    print("Dio Exception: ${exception.toString()}");
    if (exception.error is SocketException) {
      throw DioErrorException(ErrorMessage.CONNECTION_ERROR);
    } else if (exception.type == DioErrorType.CONNECT_TIMEOUT) {
      throw DioErrorException(ErrorMessage.TIMEOUT_ERROR);
    } else if (exception.type == DioErrorType.RESPONSE) {
      throw DioErrorException(
          "${exception.response.statusCode}: ${ErrorMessage.UNEXPECTED_ERROR}");
    } else {
      throw ServerErrorException(ErrorMessage.UNEXPECTED_ERROR);
    }
  }

  void onServerErrorMessage(dynamic exception) {
    print("Server error message: $exception");
    throw ServerResponseException(exception.toString());
  }
}
