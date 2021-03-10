import 'package:flutter/material.dart';

import '../utils/logger.dart';

///This class is inspired from SWR in React
///[FutureManager] is a wrap around [Future] and [ChangeNotifier]
///
///[FutureManager] use [AsyncFutureControllerBuilder] instead of FutureBuilder to handle data
///
///[FutureManager] provide a method [asyncOperation] to handle or call async function
///

typedef FutureFunction<T> = Future<T> Function();
typedef SuccessCallBack<T> = T Function(T);
typedef ErrorCallBack = void Function(dynamic);

class FutureManager<T> extends ChangeNotifier {
  ///A future function that return the type of T
  final FutureFunction<T> futureFunction;

  /// A function that call after [asyncOperation] is success
  final SuccessCallBack<T> onSuccess;

  /// A function that call after everything is done
  final VoidCallback onDone;

  /// A function that call after there is an error
  final ErrorCallBack onError;

  /// if [reloading] is true, reload the controller to initial state
  final bool reloading;

  FutureManager(
      {this.futureFunction,
      this.reloading = false,
      this.onSuccess,
      this.onDone,
      this.onError}) {
    if (futureFunction != null) {
      asyncOperation(
        futureFunction,
        reloading: reloading,
        onSuccess: onSuccess,
        onDone: onDone,
        onError: onError,
      );
    }
  }

  ///
  bool _isLoading = true;
  T _data;
  dynamic _error;

  T get data => _data;
  dynamic get error => _error;

  ///
  bool get hasData => _data != null;
  bool get hasError => _error != null;

  ///Future that this class is doing in [asyncOperation]
  Future<T> future;
  Future<T> Function(
          {bool reloading,
          SuccessCallBack<T> onSuccess,
          VoidCallback onDone,
          ErrorCallBack onError}) refresh =
      ({reloading, onSuccess, onDone, onError}) async {
    errorLog("Refresh has not been initialized yet");
    return null;
  };

  Future<T> asyncOperation(
    FutureFunction<T> futureFunction, {
    bool reloading = false,
    SuccessCallBack<T> onSuccess,
    VoidCallback onDone,
    ErrorCallBack onError,
  }) async {
    refresh = ({reloading, onSuccess, onDone, onError}) async {
      bool shouldReload = reloading ?? this.reloading;
      SuccessCallBack<T> successCallBack = onSuccess ?? this.onSuccess;
      ErrorCallBack errorCallBack = onError ?? this.onError;
      VoidCallback onOperationDone = onDone ?? this.onDone;
      //
      bool triggerError = true;
      if (hasData) {
        triggerError = shouldReload;
      }
      try {
        if (shouldReload) resetData();
        future = futureFunction();
        T result = await future;
        if (successCallBack != null) {
          result = successCallBack?.call(result);
        }
        _data = result;
        return _data;
      } catch (exception) {
        if (triggerError) _error = exception;
        errorCallBack?.call(exception);
        return null;
      } finally {
        toggleLoading();
        onOperationDone?.call();
      }
    };
    return refresh(
        reloading: reloading,
        onSuccess: onSuccess,
        onDone: onDone,
        onError: onError);
  }

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void update([T data]) {
    if (data != null) {
      _data = data;
    }
    notifyListeners();
  }

  void resetData() {
    _isLoading = true;
    _error = null;
    _data = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _data = null;
    super.dispose();
  }
}
