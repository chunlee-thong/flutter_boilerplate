import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import '../../constant/style.dart';

class NoDataWidget extends StatelessWidget {
  final double verticalMargin;
  final String message;
  final Future<void> Function() onRefresh;
  const NoDataWidget({
    Key key,
    this.verticalMargin = 0.0,
    this.message = "No data",
    this.onRefresh,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: verticalMargin),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, style: subtitleStyle),
            if (onRefresh != null)
              SmallIconButton(
                onTap: () => onRefresh?.call(),
                margin: const EdgeInsets.symmetric(vertical: 8),
                icon:
                    Icon(FlutterIcons.refresh_faw, color: context.primaryColor),
              ),
          ],
        ),
      ),
    );
  }
}
