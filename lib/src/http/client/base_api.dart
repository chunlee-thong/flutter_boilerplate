import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../models/others/user_secret.dart';
import '../../services/auth_service.dart';
import 'http_client.dart';
import 'http_exception.dart';

class API {
  late final Dio dio;

  API({Dio? client}) {
    dio = client ?? DefaultHttpClient.dio;
  }

  final String DATA_FIELD = "data";
  final String ERROR_MESSAGE_FIELD = "message";

  ///Create an Http request method that required path and a callback functions [onSuccess]
  ///default Http method is [GET]
  Future<T> httpRequest<T>({
    required String path,
    required T Function(Response) onSuccess,
    String method = HttpMethod.GET,
    Map<String, dynamic>? query,
    Map<String, dynamic> headers = const {},
    dynamic data = const {},
    bool requiredToken = true,
    String? customToken,
    Dio? customDioClient,
  }) async {
    Response? response;
    try {
      final httpOption = Options(method: method, headers: {});
      if (requiredToken && UserSecret.instance.hasValidToken()) {
        String? token = UserSecret.instance.jwtToken;
        bool isExpired = SuraJwtDecoder.decode(token!).isExpired;
        if (isExpired) {
          token = await AuthService.refreshUserToken();
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
      );
      return onSuccess(response);
    } on DioError catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw _handleOtherError(e);
    }
  }
}

///Handle another type of exception that relate to runtime exception
HttpRequestErrorWrapper _handleOtherError(dynamic exception) {
  StackTrace? stackTrace;
  if (exception is Error) {
    stackTrace = exception.stackTrace;
  }
  errorLog("Http Request Exception Error :=> ${exception.runtimeType}: "
      "$exception"
      "\nStackTrace:  ${stackTrace.toString()}");
  return HttpRequestErrorWrapper(
    "Error: ${HttpErrorMessage.UNEXPECTED_TYPE_ERROR}",
    stackTrace,
  );
}

HttpRequestException _handleDioError(DioError exception) {
  _logDioError(exception);
  if (exception.error is SocketException) {
    return DioErrorException(HttpErrorMessage.CONNECTION_ERROR);
  }

  switch (exception.type) {
    case DioErrorType.connectTimeout:
      return DioErrorException(HttpErrorMessage.TIMEOUT_ERROR);
    case DioErrorType.response:
      if (exception.response!.statusCode == SessionExpiredException.code) {
        return SessionExpiredException();
      }
      return DioErrorException.response(exception.response);
    default:
      return DioErrorException(HttpErrorMessage.UNEXPECTED_ERROR);
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
