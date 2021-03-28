import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import 'error_widget.dart';
import 'loading_widget.dart';

class CustomStreamHandler<T> extends StatelessWidget {
  final Widget Function(T) ready;
  final Widget Function(dynamic) errorWidget;
  final Widget loading;
  final Stream<T> stream;
  final Function onRefresh;
  final bool hasAppBarOnError;

  const CustomStreamHandler({
    Key key,
    @required this.ready,
    this.loading,
    @required this.stream,
    this.onRefresh,
    this.hasAppBarOnError = false,
    this.errorWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SuraStreamHandler<T>(
      stream: stream,
      loading: loading ?? LoadingWidget(),
      onError: (dynamic error) async {},
      error: (error) {
        if (errorWidget != null) return errorWidget(error);

        return CustomErrorWidget(
          message: error.toString(),
          hasAppBar: hasAppBarOnError,
          onRefresh: onRefresh,
        );
      },
      ready: ready,
    );
  }
}
