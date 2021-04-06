import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/loading_provider.dart';
import 'loading_widget.dart';

class PageLoading extends StatelessWidget {
  final Widget child;
  const PageLoading({
    Key key,
    @required this.child,
  }) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark ? Colors.grey.withOpacity(0.2) : Colors.black26;
    return Stack(
      children: [
        child,
        Consumer<LoadingProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading)
              return Container(
                child: LoadingWidget(),
                color: color,
              );
            return SizedBox();
          },
        ),
      ],
    );
  }
}
