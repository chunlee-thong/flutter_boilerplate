import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GetItInjector<T extends Object> extends StatefulWidget {
  final T Function() create;
  final Widget child;

  ///Inject your instance that has a lifetime as this widget life cycle
  const GetItInjector({Key? key, required this.create, required this.child}) : super(key: key);

  @override
  State<GetItInjector> createState() => _GetItInjectorState<T>();
}

class _GetItInjectorState<T extends Object> extends State<GetItInjector<T>> {
  late final instance = widget.create();
  @override
  void initState() {
    GetIt.instance.registerSingleton<T>(instance);
    super.initState();
  }

  @override
  void dispose() {
    GetIt.instance.unregister<T>(instance: instance);
    if (instance is ChangeNotifier) {
      (instance as ChangeNotifier).dispose();
      debugPrint("GetIt Injector Dispose");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}