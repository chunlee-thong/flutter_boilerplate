import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../../flavor.dart';
import '../constant/app_config.dart';

enum HttpMethod {
  get,
  post,
  patch,
  put,
  delete;

  String get value => name.toUpperCase();
}

abstract class HttpClient {
  Dio get dio;
}

class DefaultDioClient extends HttpClient {
  //20seconds timeout
  static const int _timeOut = 20000;

  static final DefaultDioClient _instance = DefaultDioClient._();

  factory DefaultDioClient() {
    return _instance;
  }
  DefaultDioClient._();

  @override
  Dio get dio {
    final BaseOptions defaultOptions = BaseOptions(
      baseUrl: AppConfig.baseApiUrl[F.flavor]!,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
    );
    final dio = Dio(defaultOptions)..interceptors.add(defaultInterceptor);
    //Use isolate still cause a jank, still no idea why
    //(dio.transformer as DefaultTransformer).jsonDecodeCallback = _parseJson;

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
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

void prettyPrintJson(dynamic input) {
  if (kDebugMode) {
    var prettyString = encoder.convert(input);
    prettyString.split('\n').forEach((element) => debugPrint(element));
  }
}

final InterceptorsWrapper defaultInterceptor = InterceptorsWrapper(
  onRequest: (RequestOptions options, RequestInterceptorHandler requestInterceptorHandler) async {
    httpLog("${options.method}: ${options.path},"
        "query: ${options.queryParameters},"
        "data: ${options.data},"
        "token: ${_getLastIndexString(options.headers["authorization"])}");
    requestInterceptorHandler.next(options);
  },
  onResponse: (Response response, ResponseInterceptorHandler responseInterceptorHandler) async {
    responseInterceptorHandler.next(response);
  },
  onError: (DioError error, ErrorInterceptorHandler errorInterceptorHandler) async {
    errorInterceptorHandler.reject(error);
  },
);

String _getLastIndexString(String? data, [int length = 2]) {
  if (data == null || data == "null") return "null";
  return data.substring(data.length - length);
}
