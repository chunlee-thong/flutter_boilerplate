import 'package:flutter/material.dart';

import '../../services/async_future_controller.dart';

mixin ApiRequestMixin<Page extends StatefulWidget, T> on State<Page> {
  AsyncFutureController<T> futureController;
  Future<void> fetchData([bool reloading = false]);
  @override
  void initState() {
    futureController = AsyncFutureController();
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    futureController.dispose();
    super.dispose();
  }
}
