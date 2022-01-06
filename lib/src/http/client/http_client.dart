import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constant/app_config.dart';
import '../../utils/logger.dart';
import '../../utils/object_util.dart';

class DefaultHttpClient {
  static late final Dio dio;

  //20seconds timeout
  static const int _timeOut = 20000;

  ///Must be call when running app
  static void init() {
    final BaseOptions options = BaseOptions(
      baseUrl: AppConfig.BASE_URL,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
    );
    dio = Dio(options)..interceptors.add(defaultInterceptor);
    (dio.transformer as DefaultTransformer).jsonDecodeCallback = _parseJson;

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

const JsonDecoder decoder = JsonDecoder();
const JsonEncoder encoder = JsonEncoder.withIndent('  ');

final InterceptorsWrapper defaultInterceptor = InterceptorsWrapper(
  onRequest: (RequestOptions options, RequestInterceptorHandler requestInterceptorHandler) async {
    httpLog("${options.method}: ${options.path},"
        "query: ${options.queryParameters},"
        "data: ${options.data},"
        "token: ${ObjectUtils.getLastIndexString(options.headers["authorization"])}");
    requestInterceptorHandler.next(options);
  },
  onResponse: (Response response, ResponseInterceptorHandler responseInterceptorHandler) async {
    //prettyPrintJson(response.data);
    responseInterceptorHandler.next(response);
  },
  onError: (DioError error, ErrorInterceptorHandler errorInterceptorHandler) async {
    errorInterceptorHandler.reject(error);
  },
);

void prettyPrintJson(dynamic input) {
  if (kDebugMode) {
    var prettyString = encoder.convert(input);
    prettyString.split('\n').forEach((element) => debugPrint(element));
  }
}
