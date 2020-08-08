import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './../constant/app_constant.dart';
import '../api_service/base_http_exception.dart';

class BaseApiProvider {
  final dio = Dio()
    ..options.baseUrl = AppConstant.BASE_URL
    ..options.connectTimeout = 20000
    ..options.receiveTimeout = 20000;
  static JsonDecoder decoder = JsonDecoder();
  static JsonEncoder encoder = JsonEncoder.withIndent('  ');

  final fss = FlutterSecureStorage();
  final unexpectedErrorMessage = "An unexpected error occur!";
  final socketErrorMessage =
      "Error connecting to server. Please check your internet connection or Try again later!";
  final timeOutMessage =
      "Connection timeout. Please check your internet connection or Try agian later!";

  BaseApiProvider() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          print("${options.method}: ${options.path}");
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
    //convert map to json String
    var prettyString = encoder.convert(input);
    prettyString.split('\n').forEach((element) => print(element));
  }

  Future<T> onRequest<T>(Function onHttpRequest) async {
    try {
      return await onHttpRequest();
    } on TypeError catch (exception) {
      print("Type Error Exception: ${exception.toString()}");
      print("Stack strace: ${exception.stackTrace.toString()}");
      throw exception;
    } on DioError catch (exception) {
      print("Dio Exception catch: ${exception.toString()}");
      if (exception.error is SocketException) {
        throw DioErrorException(socketErrorMessage);
      } else if (exception.type == DioErrorType.CONNECT_TIMEOUT) {
        throw DioErrorException(timeOutMessage);
      } else if (exception.type == DioErrorType.RESPONSE) {
        throw DioErrorException(
            "${exception.response.statusCode}: $unexpectedErrorMessage");
      } else {
        throw ServerErrorException(unexpectedErrorMessage);
      }
    } catch (exception) {
      throw ServerResponseException(exception.toString());
    }
  }
}
