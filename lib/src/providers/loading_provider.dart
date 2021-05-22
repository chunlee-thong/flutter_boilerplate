import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoadingProvider extends ChangeNotifier {
  bool isLoading = false;
  static BuildContext? _context;

  ///Loading provider need a stable context, so it's best to initialize with
  ///the context that always active. eg. Builder context of MaterialApp
  ///If you're trying to use a custom context, sometime it will throw an error
  ///if our widget has been disable
  static void init(BuildContext childContext) {
    _context = childContext;
  }

  static void toggleLoading([bool? value]) {
    if (_context == null) {
      throw FlutterError("Please initialize a LoadingProvider with init() function");
    }
    Provider.of<LoadingProvider>(_context!, listen: false)._toggleLoading(value);
  }

  void _toggleLoading([bool? value]) {
    isLoading = value ?? !isLoading;
    notifyListeners();
  }
}
