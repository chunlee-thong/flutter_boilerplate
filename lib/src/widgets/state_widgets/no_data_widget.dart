import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

import '../../core/constant/app_assets.dart';
import '../../core/style/textstyle.dart';
import '../../widgets/images/svg_asset.dart';

class NoDataWidget extends StatelessWidget {
  final double verticalMargin;
  final String message;
  final Future<void> Function()? onRefresh;

  const NoDataWidget({
    Key? key,
    this.message = "There is nothing here!",
    this.verticalMargin = 0.0,
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
            _buildNoDataIcon(),
            const SpaceY(16),
            Text(message, style: kSubtitleStyle.normal),
            if (onRefresh != null)
              SkadiIconButton(
                onTap: () => onRefresh?.call(),
                margin: const EdgeInsets.symmetric(vertical: 8),
                icon: Icon(
                  Icons.refresh,
                  color: context.primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataIcon() {
    return const SvgAsset.iconOnly(
      icon: AppAssets.empty,
      size: 54,
    );
  }
}
