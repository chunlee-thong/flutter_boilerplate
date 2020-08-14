import 'package:flutter/material.dart';
import '../../services/base_stream.dart';
import '../common/loading_widget.dart';
import 'package:provider/provider.dart';

class ExtendStreamConsumer<C extends BaseStream<T>, T> extends StatelessWidget {
  final Widget Function(BuildContext, T) builder;
  final Widget onEmpty;
  final Widget Function(String) onError;

  const ExtendStreamConsumer({
    Key key,
    @required this.builder,
    this.onEmpty,
    this.onError,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final baseStream = Provider.of<C>(context, listen: false);
    return StreamBuilder<T>(
      stream: baseStream.stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData) {
          return builder(context, snapshot.data);
        } else if (snapshot.hasError) {
          if (onError == null)
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
              ),
            );
          return onError(snapshot.error);
        } else {
          if (onEmpty == null) return LoadingWidget();
          return onEmpty;
        }
      },
    );
  }
}
