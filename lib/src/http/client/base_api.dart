import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../services/auth_service.dart';
import '../../services/local_storage_service/local_storage_service.dart';
import 'http_client.dart';
import 'http_exception.dart';

///Data field from api response
const String kDataField = "data";

///Data field from api response
const String kMessageField = "message";

class API {
  late final Dio dio;
  final bool authorization;
  final CancelToken cancelToken = CancelToken();

  API({Dio? client, this.authorization = true}) {
    dio = client ?? DioHttpClient.dioInstance;
  }

  ///Create an Http request method that required path and a callback functions [onSuccess]
  ///default Http method is [GET]
  Future<T> httpRequest<T>({
    required String path,
    required T Function(Response) onSuccess,
    String method = HttpMethod.get,
    Map<String, dynamic>? query,
    Map<String, dynamic> headers = const {},
    dynamic data = const {},
    bool? requiredToken,
    String? customToken,
    Dio? customDioClient,
  }) async {
    Response? response;
    try {
      final httpOption = Options(method: method, headers: {});
      final bool needToken = requiredToken ?? authorization;
      if (needToken) {
        String? token = await LocalStorage.read(key: kTokenKey);
        if (token == null) throw Exception("Invalid Token");
        bool isExpired = SuraJwtDecoder.decode(token).isExpired;
        if (isExpired) {
          token = await AuthService.refreshUserToken(customDioClient ?? dio);
        }
        httpOption.headers!['Authorization'] = "bearer $token";
      }
      if (customToken != null) {
        httpOption.headers!['Authorization'] = "bearer $customToken";
      }
      httpOption.headers!.addAll(headers);
      response = await (customDioClient ?? dio).request(
        path,
        options: httpOption,
        queryParameters: query,
        data: data,
        cancelToken: cancelToken,
      );
      return onSuccess(response);
    } on DioError catch (e) {
      throw _handleDioError(e);
    } catch (e, stackTrace) {
      throw _handleOtherError(e, stackTrace);
    }
  }
}

///Handle another type of exception that relate to runtime exception
HttpRequestErrorWrapper _handleOtherError(dynamic exception, StackTrace stackTrace) {
  errorLog("Http Request Exception Error :=> ${exception.runtimeType}: "
      "$exception"
      "\nStackTrace:  ${stackTrace.toString()}");
  return HttpRequestErrorWrapper(
    "Error: ${HttpErrorMessage.unexpectedTypeError}",
    stackTrace,
  );
}

HttpRequestException _handleDioError(DioError exception) {
  _logDioError(exception);
  if (exception.error is SocketException) {
    return DioErrorException(HttpErrorMessage.connectionError);
  }

  switch (exception.type) {
    case DioErrorType.connectTimeout:
      return DioErrorException(HttpErrorMessage.timeoutError);
    case DioErrorType.response:
      if (exception.response!.statusCode == SessionExpiredException.code) {
        return SessionExpiredException();
      }
      return DioErrorException.response(exception.response);
    default:
      return DioErrorException(HttpErrorMessage.unexpectedError);
  }
}

void _logDioError(DioError exception) {
  String errorMessage = "Dio error :=> ${exception.requestOptions.path}";
  if (exception.response != null) {
    errorMessage += ", Response: ${exception.response?.statusCode} => ${exception.response!.data.toString()}";
  } else {
    errorMessage += ", ${exception.message}";
  }
  httpLog(errorMessage);
}
