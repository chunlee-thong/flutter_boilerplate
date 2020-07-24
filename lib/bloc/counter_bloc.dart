import 'package:flutter_boiler_plate/bloc/base_extend_stream.dart';

class CounterBloc extends BaseStream<int> {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    addData(_count);
  }

  void decrement() {
    _count--;
    addData(_count);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
