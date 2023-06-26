import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/src/services/index.dart';
import 'package:skadi/skadi.dart';

import '../../services/local_storage_service/local_storage_service.dart';
import 'http_client.dart';
import 'http_exception.dart';

///Data field from api response
const String kDataField = "data";

///Data field from api response
const String kMessageField = "message";

abstract class API {
  final HttpClient httpClient;
  final bool authorization;
  final String? pathPrefix;

  final Map<String, CancelToken> _cancelTokens = {};

  API({
    required this.httpClient,
    this.authorization = true,
    this.pathPrefix,
  });

  ///Create an Http request method that required path and a callback functions [onSuccess]
  ///default Http method is [GET]
  Future<T> httpRequest<T>({
    required String path,
    required T Function(Response) onSuccess,
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? query,
    Map<String, dynamic> headers = const {},
    dynamic data = const {},
    bool? requiredToken,
    Dio? customDioClient,
  }) async {
    Response? response;
    try {
      final httpOption = Options(method: method.value, headers: {});
      final bool requiredAuthorization = requiredToken ?? authorization;

      ///Bearer token authorization logic
      if (requiredAuthorization) {
        String? token = await LocalStorage.read(key: kTokenKey);
        if (token == null) throw SessionExpiredException();
        bool isExpired = JwtDecoder.decode(token).isExpired;
        if (isExpired) {
          token = await authService.refreshUserToken(customDioClient ?? httpClient.dio);
        }
        httpOption.headers!['Authorization'] = "bearer $token";
      }

      httpOption.headers!.addAll(headers);
      if (pathPrefix != null) {
        path = pathPrefix! + path;
      }

      ///Create cancel token
      final cancelTokenKey = path;
      _cancelTokens[cancelTokenKey] = CancelToken();

      response = await (customDioClient ?? httpClient.dio).request(
        path,
        options: httpOption,
        queryParameters: query,
        data: data,
        cancelToken: _cancelTokens[cancelTokenKey],
      );
      return onSuccess(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  ///
  void cancelRequest([String? key]) {
    const reason = 'User cancel request';
    if (key != null) {
      _cancelTokens[key]?.cancel(reason);
    }
    for (var token in _cancelTokens.values) {
      token.cancel(reason);
    }
  }
}

HttpRequestException _handleDioError(DioException exception) {
  _logDioError(exception);
  if (exception.error is SocketException) {
    return NoInternetException();
  }

  switch (exception.type) {
    case DioExceptionType.connectionError:
      return NoInternetException();
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return DioErrorException.timeout();
    case DioExceptionType.badResponse:
      if (exception.response!.statusCode == SessionExpiredException.code) {
        return SessionExpiredException();
      }
      return DioErrorException.response(exception.response);
    case DioExceptionType.unknown:
    case DioExceptionType.badCertificate:
      return DioErrorException(HttpErrorMessage.unexpectedError);
    case DioExceptionType.cancel:
      return RequestCancelException();
  }
}

void _logDioError(DioException exception) {
  String errorMessage = "Dio error :=> ${exception.requestOptions.path}";
  if (exception.response != null) {
    errorMessage += ", Response: ${exception.response?.statusCode} => ${exception.response!.data.toString()}";
  } else {
    errorMessage += ", ${exception.message}";
  }
  httpLog(errorMessage);
}
