import 'package:flutter/material.dart';
import 'package:sura_manager/sura_manager.dart';

mixin ApiRequestMixin<Page extends StatefulWidget, T> on State<Page> {
  late FutureManager<T> futureController;
  Future<void> fetchData([bool reloading = false]);
  @override
  void initState() {
    futureController = FutureManager();
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    futureController.dispose();
    super.dispose();
  }
}
