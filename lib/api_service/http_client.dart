import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import '../constant/config.dart';
import '../utils/logger.dart';

final BaseOptions options = BaseOptions(
  baseUrl: Config.BASE_URL,
  connectTimeout: 25000,
  receiveTimeout: 25000,
);

final defaultDioClient = Dio()
  ..options = options
  ..interceptors.add(defaultInterceptor)
  ..interceptors.add(
    DioCacheManager(CacheConfig(baseUrl: Config.BASE_URL)).interceptor,
  );

final JsonDecoder decoder = JsonDecoder();
final JsonEncoder encoder = JsonEncoder.withIndent('  ');

final InterceptorsWrapper defaultInterceptor = InterceptorsWrapper(
  onRequest: (RequestOptions options) async {
    httpLog("${options.method}: ${options.path},"
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

void prettyPrintJson(dynamic input) {
  var prettyString = encoder.convert(input);
  prettyString.split('\n').forEach((element) => print(element));
}
