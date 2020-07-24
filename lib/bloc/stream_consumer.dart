import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_extend_stream.dart';

class StreamConsumer<S extends BaseStream<T>, T> extends StatelessWidget {
  final Widget Function(BuildContext, T) builder;
  final Widget onEmpty;
  final Widget Function(String) onError;

  const StreamConsumer({
    Key key,
    @required this.builder,
    this.onEmpty,
    this.onError,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final S baseStream = Provider.of<S>(context, listen: false);
    return StreamBuilder<T>(
      stream: baseStream.stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData) {
          return builder(context, snapshot.data);
        } else if (snapshot.hasError) {
          if (onError == null)
            return Text(
              snapshot.error,
              textAlign: TextAlign.center,
            );
          return onError(snapshot.error);
        } else {
          if (onEmpty == null) return SizedBox();
          return onEmpty;
        }
      },
    );
  }
}
