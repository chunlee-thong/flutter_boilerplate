import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../api_service/http_exception.dart';
import '../constant/app_constant.dart';

class BaseStream<T> {
  BehaviorSubject<T> _controller;
  BaseStream([T initialData]) {
    _controller = BehaviorSubject<T>();
    if (initialData != null) {
      this.addData(initialData);
    }
  }

  BehaviorSubject<T> get stream => _controller.stream;

  bool get hasData => _controller.hasValue;

  T get value => _controller.value;

  void addData(T data) {
    if (!_controller.isClosed) _controller.add(data);
  }

  Future<T> asyncOperation(
    Future<T> Function() doingOperation, {
    bool loadingOnRefresh = false,
    void Function(T) onDone,
    void Function(dynamic) onError,
  }) async {
    bool shouldAddError = true;
    if (this._controller.hasValue) {
      shouldAddError = loadingOnRefresh;
    }
    try {
      if (shouldAddError) this.addData(null);
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
    if (!_controller.isClosed) _controller.addError(error);
  }

  void dispose() async {
    _controller.close();
  }
}
