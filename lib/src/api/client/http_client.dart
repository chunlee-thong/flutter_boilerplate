import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

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
  }
}

const JsonDecoder decoder = JsonDecoder();
const JsonEncoder encoder = JsonEncoder.withIndent('  ');

final InterceptorsWrapper defaultInterceptor = InterceptorsWrapper(
  onRequest: (RequestOptions options,
      RequestInterceptorHandler requestInterceptorHandler) async {
    httpLog("${options.method}: ${options.path},"
        "query: ${options.queryParameters},"
        "data: ${options.data},"
        "token: ${ObjectUtils.getLastIndexString(options.headers["authorization"])}");
    requestInterceptorHandler.next(options);
  },
  onResponse: (Response response,
      ResponseInterceptorHandler responseInterceptorHandler) async {
    //prettyPrintJson(response.data);
    responseInterceptorHandler.next(response);
  },
  onError:
      (DioError error, ErrorInterceptorHandler errorInterceptorHandler) async {
    errorInterceptorHandler.reject(error);
  },
);

void prettyPrintJson(dynamic input) {
  var prettyString = encoder.convert(input);
  prettyString.split('\n').forEach((element) => log(element));
}
