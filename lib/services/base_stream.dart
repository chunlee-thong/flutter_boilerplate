import 'package:rxdart/rxdart.dart';
import '../api_service/base_http_exception.dart';
import '../repository/base_repository.dart';

class BaseStream<T> extends BaseRepository {
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
    void Function(String) onError,
  }) async {
    try {
      if (loadingOnRefresh) this.addData(null);
      T data = await doingOperation();
      if (onDone != null) onDone(data);
      this.addData(data);
      return data;
    } on TypeError catch (_) {
      if (onError != null) {
        onError("Something went wrong");
      } else {
        this.addError("Something went wrong!");
      }
      return null;
    } on BaseHttpException catch (exception) {
      if (onError != null) {
        onError(exception.toString());
      } else {
        this.addError(exception.toString());
      }
      return null;
    }
  }

  void addError(String error) {
    if (!_controller.isClosed) _controller.addError(error);
  }

  void dispose() async {
    _controller.close();
  }
}
