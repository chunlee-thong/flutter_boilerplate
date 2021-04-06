import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoadingProvider extends ChangeNotifier {
  bool isLoading = false;

  static void toggleLoading(BuildContext context) {
    Provider.of<LoadingProvider>(context, listen: false)._toggleLoading();
  }

  void _toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
