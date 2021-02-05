import 'package:flutter/material.dart';

///This class is inspired from SWR in React
///[AsyncFutureController] is a wrap around [Future] and [ChangeNotifier]
///
///[AsyncFutureController] use [AsyncFutureControllerBuilder] instead of FutureBuilder to handle data
///
///[AsyncFutureController] provide a method [asyncOperation] to handle or call async function
///

class AsyncFutureController<T> extends ChangeNotifier {
  ///
  bool _isLoading = true;
  T _data;
  dynamic _error;

  ///
  bool get hasData => _data != null;
  bool get isLoading => _isLoading;
  bool get hasError => _error != null;

  dynamic get error => _error;
  T get data => _data;

  ///Future that this class is doing in [asyncOperation]
  Future<T> future;

  Future<T> asyncOperation(
    ///A future function that return the type of T
    Future<T> Function() doingOperation, {

    /// if [reloading] is true, reload the controller to initial state
    bool reloading = false,

    /// A function that call after [asyncOperation] is success
    T Function(T) onSuccess,

    /// A function that call after everything is done
    void Function() onDone,

    /// A function that call after there is an error
    void Function(dynamic) onError,
  }) async {
    bool shouldApplyError = true;
    if (this.hasData) {
      shouldApplyError = reloading;
    }
    try {
      if (reloading) resetData();
      future = doingOperation();
      T result = await future;
      if (onSuccess != null) {
        result = onSuccess?.call(result);
      }
      _data = result;
      return _data;
    } catch (exception) {
      if (shouldApplyError) _error = exception;
      onError?.call(exception);
      return null;
    } finally {
      toggleLoading();
      onDone?.call();
    }
  }

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void resetData() {
    _error = null;
    _isLoading = true;
    _data = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _data = null;
    super.dispose();
  }
}
