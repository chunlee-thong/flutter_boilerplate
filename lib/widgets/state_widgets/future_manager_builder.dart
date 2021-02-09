import 'package:flutter/material.dart';

import '../../services/future_manager.dart';
import '../../widgets/state_widgets/loading_widget.dart';
import 'error_widget.dart';

class FutureManagerBuilder<T> extends StatefulWidget {
  final FutureManager<T> futureManager;
  final Widget loading;
  final Widget Function(dynamic) error;
  final void Function(dynamic) onError;
  final Widget Function(BuildContext, T) ready;
  const FutureManagerBuilder({
    Key key,
    @required this.futureManager,
    @required this.ready,
    this.loading,
    this.error,
    this.onError,
  }) : super(key: key);
  @override
  _FutureManagerBuilderState createState() => _FutureManagerBuilderState<T>();
}

class _FutureManagerBuilderState<T> extends State<FutureManagerBuilder<T>> {
  //
  void listener() {
    setState(() {});
    if (widget.futureManager.hasError) {
      widget.onError?.call(widget.futureManager.error);
    }
  }

  @override
  void initState() {
    widget.futureManager.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.futureManager.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.futureManager.hasData) {
      return widget.ready(context, widget.futureManager.data);
    } else if (widget.futureManager.hasError) {
      if (widget.error != null) {
        return widget.error(widget.futureManager.error);
      }
      return CustomErrorWidget(message: widget.futureManager.error);
    } else if (widget.loading != null) {
      return widget.loading;
    }
    return LoadingWidget();
  }
}
