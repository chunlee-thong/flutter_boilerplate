import 'dart:convert';

import 'package:dio/dio.dart';

import '../../constant/app_config.dart';
import '../../utils/logger.dart';
import '../../utils/object_util.dart';

class BaseHttpClient {
  static late final Dio dio;

  ///
  static void init() {
    final BaseOptions options = BaseOptions(
      baseUrl: AppConfig.BASE_URL,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    dio = Dio(options)..interceptors.add(defaultInterceptor);
  }
}

final JsonDecoder decoder = JsonDecoder();
final JsonEncoder encoder = JsonEncoder.withIndent('  ');

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
  var prettyString = encoder.convert(input);
  prettyString.split('\n').forEach((element) => print(element));
}
