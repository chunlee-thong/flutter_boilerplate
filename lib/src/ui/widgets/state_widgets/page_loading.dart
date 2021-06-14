import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/loading_provider.dart';
import 'loading_widget.dart';

class PageLoading extends StatefulWidget {
  final Widget child;
  const PageLoading({
    Key? key,
    required this.child,
  });

  @override
  _PageLoadingState createState() => _PageLoadingState();
}

class _PageLoadingState extends State<PageLoading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoadingProvider.init(context);
    final color = Theme.of(context).brightness == Brightness.dark ? Colors.grey.withOpacity(0.2) : Colors.black26;
    return Stack(
      children: [
        widget.child,
        Consumer<LoadingProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading)
              return Container(
                child: const LoadingWidget(),
                color: color,
              );
            return SizedBox();
          },
        ),
      ],
    );
  }
}
