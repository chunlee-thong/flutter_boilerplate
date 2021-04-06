import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoadingProvider extends ChangeNotifier {
  bool isLoading = false;

  static void toggleLoading(BuildContext context, [bool value]) {
    Provider.of<LoadingProvider>(context, listen: false)._toggleLoading(value);
  }

  void _toggleLoading([bool value]) {
    isLoading = value ?? !isLoading;
    notifyListeners();
  }
}
