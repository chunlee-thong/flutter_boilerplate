import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';

mixin ApiRequestMixin<Page extends StatefulWidget, T extends Object> on State<Page> {
  late FutureManager<T> futureManager;
  Future<void> fetchData([bool reloading = false]);
  @override
  void initState() {
    futureManager = FutureManager();
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    futureManager.dispose();
    super.dispose();
  }
}
