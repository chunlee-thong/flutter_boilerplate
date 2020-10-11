import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import '../constant/config.dart';

import '../constant/app_constant.dart';
import 'base_http_exception.dart';

class BaseApiService {
  final dio = Dio();
  final BaseOptions options = BaseOptions(
    baseUrl: Config.BASE_URL,
    connectTimeout: 20000,
    receiveTimeout: 20000,
  );
  static JsonDecoder decoder = JsonDecoder();
  static JsonEncoder encoder = JsonEncoder.withIndent('  ');

  InterceptorsWrapper defaultInterceptor = InterceptorsWrapper(
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
  );

  BaseApiService() {
    dio.interceptors.add(defaultInterceptor);
    dio.interceptors.add(
      DioCacheManager(CacheConfig(baseUrl: Config.BASE_URL)).interceptor,
    );
  }

  Future<T> onRequest<T>({
    @required String path,
    @required String method,
    @required T Function(Response) onSuccess,
    Map<String, dynamic> query = const {},
    dynamic data = const {},
    bool requiredToken = false,
  }) async {
    try {
      final httpOption = Options(method: method);
      if (requiredToken) {
        httpOption.headers['Authorization'] = "bearer ${AppConstant.TOKEN}";
      }
      Response response = await dio.request(
        path,
        options: httpOption,
        queryParameters: query,
        data: data,
      );
      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          response.data['status'] == 1) {
        return onSuccess(response);
      } else {
        throw response.data['message'];
      }
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

  void onDioError(DioError exception) {
    print("Dio Exception: ${exception.toString()}");
    if (exception.error is SocketException) {
      ///Socket exception mostly from internet connection or host
      throw DioErrorException(ErrorMessage.CONNECTION_ERROR);
    } else if (exception.type == DioErrorType.CONNECT_TIMEOUT) {
      ///Connection timeout due to internet connection or server
      throw DioErrorException(ErrorMessage.TIMEOUT_ERROR);
    } else if (exception.type == DioErrorType.RESPONSE) {
      ///Error provided by server
      int code = exception.response.statusCode;
      String serverMessage =
          exception.response.data['error'] ?? ErrorMessage.UNEXPECTED_ERROR;
      throw DioErrorException("$code: $serverMessage");
    } else {
      throw ServerErrorException(ErrorMessage.UNEXPECTED_ERROR);
    }
  }

  void onServerErrorMessage(dynamic exception) {
    print("Server error message: $exception");
    throw ServerResponseException(exception.toString());
  }

  void prettyPrintJson(dynamic input) {
    var prettyString = encoder.convert(input);
    prettyString.split('\n').forEach((element) => print(element));
  }
}
