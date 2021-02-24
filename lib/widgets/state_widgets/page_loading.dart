import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import 'loading_widget.dart';

class PageLoading extends StatelessWidget {
  final ValueNotifier<bool> loadingNotifier;
  final Widget child;
  final Color loadingBarrierColor;
  const PageLoading({
    Key key,
    @required this.child,
    @required this.loadingNotifier,
    this.loadingBarrierColor,
  }) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.withOpacity(0.2)
        : Colors.black26;

    return Stack(
      children: [
        child,
        ValueObserver<bool>(
          valueNotifier: loadingNotifier,
          child: (isLoading) {
            if (isLoading)
              return Container(
                child: LoadingWidget(),
                color: loadingBarrierColor ?? color,
              );
            return SizedBox();
          },
        ),
      ],
    );
  }
}
