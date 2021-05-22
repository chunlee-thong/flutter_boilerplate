import 'dart:convert';

import 'package:dio/dio.dart';

import '../../constant/app_config.dart';
import '../../utils/logger.dart';
import '../../utils/object_util.dart';

class BaseHttpClient {
  static Dio dio;

  static void init() {
    final BaseOptions options = BaseOptions(
      baseUrl: AppConfig.BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );

    dio = Dio(options)..interceptors.add(defaultInterceptor);
  }
}

final JsonDecoder decoder = JsonDecoder();
final JsonEncoder encoder = JsonEncoder.withIndent('  ');

final InterceptorsWrapper defaultInterceptor = InterceptorsWrapper(
  onRequest: (RequestOptions options) async {
    httpLog("${options.method}: ${options.path},"
        "query: ${options.queryParameters},"
        "data: ${options.data},"
        "token: ${ObjectUtils.getLastIndexString(options.headers["authorization"])}");
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
