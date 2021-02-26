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

  FutureManager({this.futureFunction, this.reloading = false, this.onSuccess, this.onDone, this.onError}) {
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
  bool isLoading = true;
  T data;
  dynamic error;

  ///
  bool get hasData => data != null;
  bool get hasError => error != null;

  ///Future that this class is doing in [asyncOperation]
  Future<T> future;
  Future<T> Function({bool reloading, SuccessCallBack<T> onSuccess, VoidCallback onDone, ErrorCallBack onError}) refresh =
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
        data = result;
        return data;
      } catch (exception) {
        if (triggerError) error = exception;
        errorCallBack?.call(exception);
        return null;
      } finally {
        toggleLoading();
        onOperationDone?.call();
      }
    };
    return refresh(reloading: reloading, onSuccess: onSuccess, onDone: onDone, onError: onError);
  }

  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  void resetData() {
    error = null;
    isLoading = true;
    data = null;
    notifyListeners();
  }

  @override
  void dispose() {
    data = null;
    super.dispose();
  }
}
