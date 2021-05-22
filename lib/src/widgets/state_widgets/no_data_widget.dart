import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_theme_color.dart';
import '../../constant/style_decoration.dart';

class NoDataWidget extends StatelessWidget {
  final double verticalMargin;
  final String message;
  final Future<void> Function()? onRefresh;

  const NoDataWidget({
    Key? key,
    this.verticalMargin = 0.0,
    this.message = "There is nothing here!",
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
            buildImage(),
            SpaceY(16),
            Text(message, style: kSubtitleStyle.normal),
            if (onRefresh != null)
              SuraIconButton(
                onTap: () => onRefresh?.call(),
                margin: const EdgeInsets.symmetric(vertical: 8),
                icon: Icon(
                  FlutterIcons.refresh_faw,
                  color: context.primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Icon(
      FlutterIcons.cloud_off_mdi,
      size: 54,
      color: AppColor.accent,
    );
  }
}
