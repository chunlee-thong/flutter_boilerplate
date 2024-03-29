import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../../flavor.dart';
import '../constant/app_config.dart';
import '../utilities/logger.dart';

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
  ///20 seconds timeout
  static const Duration _timeOut = Duration(seconds: 20);

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
    (dio.httpClientAdapter as IOHttpClientAdapter).validateCertificate = (certificate, host, port) {
      return true;
    };
    return dio;
  }
}

final InterceptorsWrapper defaultInterceptor = InterceptorsWrapper(
  onRequest: (RequestOptions options, RequestInterceptorHandler requestInterceptorHandler) async {
    final token = _getLastIndexString(options.headers["Authorization"]);
    Map logString = {
      options.method: options.baseUrl + options.path,
      "query": options.queryParameters,
      "data": options.data,
      "authorization": token,
    };
    logger.i(logString);
    requestInterceptorHandler.next(options);
  },
  onResponse: (Response response, ResponseInterceptorHandler responseInterceptorHandler) async {
    responseInterceptorHandler.next(response);
  },
  onError: (DioException error, ErrorInterceptorHandler errorInterceptorHandler) async {
    errorInterceptorHandler.reject(error);
  },
);

String _getLastIndexString(String? data, [int length = 2]) {
  if (data == null || data == "null") return "null";
  return data.substring(data.length - length);
}
