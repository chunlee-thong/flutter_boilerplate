import 'package:flutter/material.dart';

import '../../services/async_future_controller.dart';
import '../../widgets/state_widgets/loading_widget.dart';

class AsyncFutureControllerBuilder<T> extends StatefulWidget {
  final AsyncFutureController<T> futureController;
  final Widget loading;
  final Widget Function(dynamic) error;
  final void Function(dynamic) onError;
  final Widget Function(BuildContext, T) ready;
  const AsyncFutureControllerBuilder({
    Key key,
    @required this.futureController,
    @required this.ready,
    this.loading,
    this.error,
    this.onError,
  }) : super(key: key);
  @override
  _AsyncFutureControllerBuilderState createState() => _AsyncFutureControllerBuilderState<T>();
}

class _AsyncFutureControllerBuilderState<T> extends State<AsyncFutureControllerBuilder<T>> {
  //
  void listener() {
    setState(() {});
    if (widget.futureController.hasError) {
      widget.onError?.call(widget.futureController.error);
    }
  }

  @override
  void initState() {
    widget.futureController.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.futureController.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.futureController.hasData) {
      return widget.ready(context, widget.futureController.data);
    } else if (widget.futureController.hasError) {
      if (widget.error != null) {
        return widget.error(widget.futureController.error);
      }
      return buildDefaultError();
    } else if (widget.loading != null) {
      return widget.loading;
    }
    return LoadingWidget();
  }

  Widget buildDefaultError() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          widget.futureController.error.toString(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
