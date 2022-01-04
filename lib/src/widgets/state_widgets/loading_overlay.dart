import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/loading_overlay_provider.dart';
import '../ui_helper.dart';
import 'loading_widget.dart';

class LoadingOverlay extends StatefulWidget {
  final Widget child;
  const LoadingOverlay({Key? key, required this.child}) : super(key: key);

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
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
              widget.child,
              Consumer<LoadingOverlayProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Container(
                      child: const LoadingWidget(),
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
