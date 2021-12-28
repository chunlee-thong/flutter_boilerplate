import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_constant.dart';
import '../../models/others/user_credential.dart';
import '../../services/auth_service.dart';
import '../../utils/logger.dart';
import 'http_client.dart';
import 'http_exception.dart';

class API {
  late final Dio dio;

  API({Dio? customDio}) {
    if (customDio == null) {
      dio = DefaultHttpClient.dio;
    } else {
      dio = customDio;
    }
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
      if (requiredToken && UserCredential.instance.hasValidToken()) {
        String? token = UserCredential.instance.jwtToken;
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
      if (customDioClient != null) {
        response = await customDioClient.request(
          path,
          options: httpOption,
          queryParameters: query,
          data: data,
        );
      } else {
        response = await dio.request(
          path,
          options: httpOption,
          queryParameters: query,
          data: data,
        );
      }
      return onSuccess(response);
    } on DioError catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw _handleOtherError(e);
    }
  }
}

///Handle another type of exception that relate to Error
dynamic _handleOtherError(dynamic exception) {
  String? stackTrace = "";
  if (exception is Exception) {
    stackTrace = exception.toString();
  } else {
    stackTrace = exception?.stackTrace?.toString() ?? "";
  }
  errorLog("Http Request Exception Error :=> ${exception.runtimeType}: "
      "$exception"
      "\nStackTrace:  $stackTrace");
  if (exception is Error) {
    return HttpRequestErrorWrapper(
      "Error: ${ErrorMessage.UNEXPECTED_TYPE_ERROR}",
      exception.stackTrace,
    );
  } else {
    return HttpRequestErrorWrapper(ErrorMessage.UNEXPECTED_ERROR);
  }
}

dynamic _handleDioError(DioError exception) {
  _logDioError(exception);
  if (exception.error is SocketException) {
    return DioErrorException(ErrorMessage.CONNECTION_ERROR);
  }

  switch (exception.type) {
    case DioErrorType.connectTimeout:
      return DioErrorException(ErrorMessage.TIMEOUT_ERROR);
    case DioErrorType.response:
      if (exception.response!.statusCode == SessionExpiredException.code) {
        return SessionExpiredException();
      }
      return DioErrorException.response(exception.response!);
    default:
      return DioErrorException(ErrorMessage.UNEXPECTED_ERROR);
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
