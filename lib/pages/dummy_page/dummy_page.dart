import 'package:flutter/material.dart';
import '../../bloc/another_counter_bloc.dart';
import '../../widgets/state_widgets/extend_stream_consumer.dart';
import 'package:provider/provider.dart';

class DummyPage extends StatefulWidget {
  @override
  _DummyPageState createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  AnotherCounterBloc anotherCounterBloc;

  void initial() {
    anotherCounterBloc.asyncOperation(() async {
      await Future.delayed(Duration(seconds: 3));
      return Future.value(10);
    });
  }

  @override
  void initState() {
    anotherCounterBloc = AnotherCounterBloc();
    initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: Provider<AnotherCounterBloc>(
        create: (context) => anotherCounterBloc,
        child: Center(
          child: CounterData(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          anotherCounterBloc.incrementByValue(100);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CounterData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExtendStreamConsumer<AnotherCounterBloc, int>(
      builder: (context, count) {
        return Text('$count');
      },
    );
  }
}
