import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sura_flutter/sura_flutter.dart';

///Just a class to mark another class when using GetItInjector
///Since we're using both Provider and GetIt for DI
///We need a quick way to see which method that class use
///We can do something fancy with this class later
abstract class GetItInjectable {}

class GetItInjector<T extends GetItInjectable> extends StatefulWidget {
  final T Function() create;
  final Widget child;

  ///Inject your instance that has a lifetime as this widget life cycle
  const GetItInjector({Key? key, required this.create, required this.child}) : super(key: key);

  @override
  State<GetItInjector> createState() => _GetItInjectorState<T>();
}

class _GetItInjectorState<T extends GetItInjectable> extends State<GetItInjector<T>> {
  late final instance = widget.create();

  void inject() {
    try {
      GetIt.instance.registerSingleton<T>(instance);
      infoLog("GetIt Inject: ${instance.runtimeType}");
    } catch (ex) {
      //The exception is expect when we inject 2 type of instance
      //Catch the error here so only Top-most inject type is registered
      //This is useful for when we can inject mock dependency for testing
      errorLog("Expected GetItInjector Error: ", ex);
    }
  }

  @override
  void initState() {
    inject();
    super.initState();
  }

  @override
  void dispose() {
    if (GetIt.I.isRegistered(instance: instance)) {
      GetIt.instance.unregister<T>(instance: instance);
      infoLog("GetIt Unregister: ${instance.runtimeType}");
      if (instance is ChangeNotifier) {
        (instance as ChangeNotifier).dispose();
        infoLog("GetIt Dispose: ${instance.runtimeType}");
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
