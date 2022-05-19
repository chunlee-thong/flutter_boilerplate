import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../../flavor.dart';
import '../../constant/app_config.dart';
import '../../utils/object_util.dart';

class HttpMethod {
  HttpMethod._();

  static const String get = "get";
  static const String post = "post";
  static const String patch = "patch";
  static const String put = "put";
  static const String delete = "delete";
}

class DioHttpClient {
  late final Dio _dio;
  //20seconds timeout
  static const int _timeOut = 20000;

  static final Dio dioInstance = DioHttpClient._()._dio;

  DioHttpClient._({BaseOptions? options}) {
    final BaseOptions defaultOptions = options ??
        BaseOptions(
          baseUrl: AppConfig.baseApiUrl[F.flavor]!,
          connectTimeout: _timeOut,
          receiveTimeout: _timeOut,
        );
    _dio = Dio(defaultOptions)..interceptors.add(defaultInterceptor);
    //Use isolate still cause a jank, still no idea why
    //(dio.transformer as DefaultTransformer).jsonDecodeCallback = _parseJson;

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
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
        "token: ${ObjectUtils.getLastIndexString(options.headers["authorization"])}");
    requestInterceptorHandler.next(options);
  },
  onResponse: (Response response, ResponseInterceptorHandler responseInterceptorHandler) async {
    responseInterceptorHandler.next(response);
  },
  onError: (DioError error, ErrorInterceptorHandler errorInterceptorHandler) async {
    errorInterceptorHandler.reject(error);
  },
);
