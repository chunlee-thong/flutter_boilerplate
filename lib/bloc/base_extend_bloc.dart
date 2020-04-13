import 'package:flutter_boiler_plate/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class BaseExtendBloc<T> extends BaseBloc {
  BehaviorSubject<T> controller;
  BaseExtendBloc() {
    controller = BehaviorSubject<T>();
  }

  BehaviorSubject<T> get stream => controller.stream;

  bool get hasData => controller.hasValue;

  void addData(T data) {
    if (!controller.isClosed) controller.add(data);
  }

  void addError(dynamic error) {
    if (!controller.isClosed) controller.addError(error);
  }

  void close() {
    controller.close();
  }
}
