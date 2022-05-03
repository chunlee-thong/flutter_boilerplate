import 'package:flutter/material.dart';
import 'package:sura_manager/sura_manager.dart';

mixin ApiRequestMixin<Page extends StatefulWidget, T> on State<Page> {
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
