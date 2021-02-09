import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../api_service/http_exception.dart';
import '../constant/app_constant.dart';
import '../utils/logger.dart';

///Previously call [BaseStream] or [BaseExtendBloc]
///[AsyncSubjectManager] is a wrap around bloc pattern that use [rxdart]
///[AsyncSubjectManager] provide a method [asyncOperation] to handle or call async function associated with rxdart's [BehaviorSubject]
///
class AsyncSubjectManager<T> {
  BehaviorSubject<T> _controller;
  AsyncSubjectManager([T initialData]) {
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
    ///A future function that return the type of T
    Future<T> Function() doingOperation, {

    /// if [reloading] is true, reload the controller to initial state
    bool resetStream = false,

    /// A function that call after [asyncOperation] is success
    T Function(T) onSuccess,

    /// A function that call after everything is done
    void Function() onDone,

    /// A function that call after there is an error
    void Function(dynamic) onError,
  }) async {
    bool shouldAddError = true;
    if (this._controller.hasValue) {
      shouldAddError = resetStream;
    }
    try {
      if (resetStream) this.addData(null);
      T data = await doingOperation();
      data = onSuccess?.call(data);
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
    } finally {
      onDone?.call();
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
