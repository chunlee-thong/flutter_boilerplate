import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constant/app_constant.dart';
import '../utils/logger.dart';
import 'base_http_exception.dart';
import 'http_client.dart';

class BaseApiService {
  Dio dio;
  BaseApiService({Dio dio}) {
    this.dio = dio ?? defaultDioClient;
  }

  Future<T> onRequest<T>({
    @required String path,
    @required String method,
    @required T Function(Response) onSuccess,
    Map<String, dynamic> query = const {},
    Map<String, dynamic> headers = const {},
    dynamic data = const {},
    bool requiredToken = false,
    bool ignoreResponse = false,
  }) async {
    try {
      final httpOption = Options(method: method);
      if (requiredToken) {
        headers['Authorization'] = "bearer ${AppConstant.TOKEN}";
      }
      httpOption.headers = headers;
      Response response = await dio.request(
        path,
        options: httpOption,
        queryParameters: query,
        data: data,
      );
      if (ignoreResponse == false) {
        if (response.statusCode >= 200 &&
            response.statusCode < 300 &&
            response.data['status'] == 1) {
          return onSuccess(response);
        } else {
          throw response.data['message'];
        }
      }
      return null;
    } on TypeError catch (exception) {
      onTypeError(exception);
      return null;
    } on DioError catch (exception) {
      onDioError(exception);
      return null;
    } catch (exception) {
      onServerErrorMessage(exception);
      return null;
    }
  }
}

void onTypeError(dynamic exception) {
  errorLog("Type error Stack trace: ${exception.stackTrace.toString()}");
  throw exception;
}

void onDioError(DioError exception) {
  errorLog("Dio Exception: ${exception.toString()}");
  if (exception.error is SocketException) {
    ///Socket exception mostly from internet connection or host
    throw DioErrorException(ErrorMessage.CONNECTION_ERROR);
  } else if (exception.type == DioErrorType.CONNECT_TIMEOUT) {
    ///Connection timeout due to internet connection or server
    throw DioErrorException(ErrorMessage.TIMEOUT_ERROR);
  } else if (exception.type == DioErrorType.RESPONSE) {
    ///Error provided by server
    int code = exception.response.statusCode;
    String serverMessage =
        exception.response.data['error'] ?? ErrorMessage.UNEXPECTED_ERROR;
    throw DioErrorException("$code: $serverMessage", code: code);
  } else {
    throw ServerErrorException(ErrorMessage.UNEXPECTED_ERROR);
  }
}

void onServerErrorMessage(dynamic exception) {
  errorLog("Server error message: $exception");
  throw ServerResponseException(exception.toString());
}
