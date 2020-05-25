import 'package:rxdart/rxdart.dart';
import 'base_repository.dart';

class BaseStream<T> extends BaseRepository {
  BehaviorSubject<T> controller;
  BaseStream() {
    controller = BehaviorSubject<T>();
  }

  BehaviorSubject<T> get stream => controller.stream;

  bool get hasData => controller.hasValue;

  void addData(T data) {
    if (!controller.isClosed) controller.add(data);
  }

  void operation(Function doingOperation) async {
    try {
      T data = await doingOperation();
      this.addData(data);
    } catch (exception) {
      this.addError(exception.toString());
    }
  }

  void addError(dynamic error) {
    if (!controller.isClosed) controller.addError(error);
  }

  void dispose() async {
    await controller.drain();
    controller.close();
  }
}
