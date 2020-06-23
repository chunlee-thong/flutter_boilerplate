import 'dart:io';

import 'package:flutter_boiler_plate/api_service/base_http_exception.dart';
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

  void operation(Function doingOperation,
      {bool loadingOnRefesh = false}) async {
    try {
      if (loadingOnRefesh) this.addData(null);
      T data = await doingOperation();
      this.addData(data);
    } on TypeError catch (_) {
      this.addError("Convertion error occur!");
    } on BaseHttpException catch (exception) {
      this.addError(exception.toString());
    }
  }

  void addError(String error) {
    if (!controller.isClosed) controller.addError(error);
  }

  void dispose() async {
    await controller.drain();
    controller.close();
  }
}
