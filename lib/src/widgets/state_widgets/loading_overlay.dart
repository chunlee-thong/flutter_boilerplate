import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';

class LoadingOverlayProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //
  static BuildContext? context;

  ///Loading provider need a stable context, so it's best to initialize with
  ///the context that always active. eg. Builder context of MaterialApp
  ///If you're trying to use a custom context, sometime it will throw an error
  ///if our widget has been disable
  static void init(BuildContext childContext) {
    context = childContext;
  }

  static void toggle([bool? value]) {
    if (context == null) {
      throw FlutterError("Please initialize a LoadingProvider with init() function");
    }
    Provider.of<LoadingOverlayProvider>(context!, listen: false)._toggleLoading(value);
  }

  void _toggleLoading([bool? value]) {
    _isLoading = value ?? !_isLoading;
    notifyListeners();
  }
}

class LoadingOverlayBuilder extends StatelessWidget {
  final Widget child;
  const LoadingOverlayBuilder({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark ? Colors.grey.withOpacity(0.2) : Colors.black26;
    return ChangeNotifierProvider(
      create: (context) => LoadingOverlayProvider(),
      child: Builder(
        builder: (context) {
          LoadingOverlayProvider.init(context);
          return Stack(
            children: [
              child,
              Consumer<LoadingOverlayProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Container(
                      child: const Center(child: CircularProgressIndicator()),
                      color: color,
                    );
                  }
                  return emptySizedBox;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
