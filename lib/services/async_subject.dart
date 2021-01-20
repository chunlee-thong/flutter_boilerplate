import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../api_service/http_exception.dart';
import '../constant/app_constant.dart';
import '../utils/logger.dart';

class AsyncSubject<T> {
  BehaviorSubject<T> _controller;
  AsyncSubject([T initialData]) {
    _controller = BehaviorSubject<T>();
    if (initialData != null) {
      this.addData(initialData);
    }
  }

  BehaviorSubject<T> get stream => _controller.stream;

  bool get hasData => _controller.hasValue && _controller.value != null;

  T get value => _controller.value;

  void addData(T data) {
    if (!_controller.isClosed) _controller.add(data);
  }

  Future<T> asyncOperation(
    Future<T> Function() doingOperation, {
    bool resetStream = false,
    void Function(T) onDone,
    void Function(dynamic) onError,
  }) async {
    bool shouldAddError = true;
    if (this._controller.hasValue) {
      shouldAddError = resetStream;
    }
    try {
      if (resetStream) this.addData(null);
      T data = await doingOperation();
      onDone?.call(data);
      this.addData(data);
      return data;
    } on TypeError catch (_) {
      onError?.call(ErrorMessage.UNEXPECTED_ERROR);
      if (shouldAddError) this.addError(ErrorMessage.UNEXPECTED_ERROR);
      return null;
    } on BaseHttpException catch (exception) {
      onError?.call(exception);
      if (shouldAddError) this.addError(exception);
      return null;
    } catch (exception) {
      onError?.call(exception);
      if (shouldAddError) this.addError(exception);
      return null;
    }
  }

  void addError(dynamic error) {
    if (!_controller.isClosed) {
      errorLog(error);
      _controller.sink.addError(error);
    }
  }

  void dispose() async {
    _controller.close();
  }
}
