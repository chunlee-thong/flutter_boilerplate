import '../services/base_stream.dart';

class AnotherCounterBloc extends BaseStream<int> {
  void incrementByValue(int value) {
    addData(value);
  }
}
