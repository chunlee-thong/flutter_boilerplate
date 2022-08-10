import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

///Just a class to mark another class when using GetItInjector
///Since we're using both Provider and GetIt for DI
///We need a quick way to see which method that class use
///We can do something fancy with this class later
abstract class GetItInjectable {
  void dispose();
}

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
      debugPrint("GetIt Inject: ${instance.runtimeType}");
    } catch (ex) {
      //The exception is expected when we inject 2 type of instance
      //Catch the error here so only Top-most injected type is registered
      //This is useful for when we want to inject a mock dependency for testing
      //Tip: When inject dependency for Testing, You must specific Base class Type in the Constructor type
      //Example: MyMockRepo is a class that extends MyRepo
      //GetItInjector<MyRepo>(
      //  create: ()=> MyMockRepo(),
      //  child: GetItInjector(
      //    create: ()=> MyRepo(),
      //    child: const MyWidget(),
      //  )
      // )
      //MyMockRepo will replace MyRepo below
      debugPrint("Expected GetItInjector Error: $ex");
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
      debugPrint("GetIt Unregister: ${instance.runtimeType}");
      instance.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
