import 'package:flutter/material.dart';

class StreamHandler<T> extends StatelessWidget {
  final Stream stream;
  final Widget Function(T) ready;
  final Widget Function() loading;
  final Widget Function(String, T) error;

  StreamHandler({this.stream, this.ready, this.error, this.loading});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ready(snapshot.data);
        } else if (snapshot.hasError) {
          return error(snapshot.error.toString(), snapshot.data) ?? Text(snapshot.error.toString());
        } else {
          return Center(child: loading() ?? CircularProgressIndicator());
        }
      },
    );
  }
}
