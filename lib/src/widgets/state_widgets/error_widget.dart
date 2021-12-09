import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_assets.dart';
import '../../constant/app_style_decoration.dart';
import '../../widgets/images/svg_asset.dart';
import '../common/ellipsis_text.dart';
import '../ui_helper.dart';

class CustomErrorWidget extends StatelessWidget {
  final double verticalMargin;
  final dynamic message;
  final Future<void> Function()? onRefresh;
  final bool hasAppBar;
  const CustomErrorWidget({
    Key? key,
    required this.message,
    this.hasAppBar = false,
    this.verticalMargin = 0.0,
    this.onRefresh,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (hasAppBar) {
      return Scaffold(
        appBar: UIHelper.CustomAppBar(title: ""),
        body: buildErrorWidget(context),
      );
    }
    return buildErrorWidget(context);
  }

  Widget buildErrorWidget(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: verticalMargin),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildErrorIcon(),
            const SpaceY(16),
            EllipsisText(
              message.toString(),
              style: kSubtitleStyle.normal,
              maxLines: 4,
              textAlign: TextAlign.center,
            ),
            if (onRefresh != null)
              SuraIconButton(
                onTap: () => onRefresh?.call(),
                margin: const EdgeInsets.symmetric(vertical: 8),
                icon: Icon(
                  Icons.refresh,
                  color: context.textTheme.bodyText1?.color,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorIcon() {
    return const SvgAsset(
      icon: AppAssets.ERROR_502,
      size: 54,
    );
  }
}

class FlutterCustomErrorRendering extends StatelessWidget {
  const FlutterCustomErrorRendering({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navigator.of(context).canPop() ? AppBar() : null,
      body: const Center(
        child: Text(
          'Rendering Error! Check stacktrace for more detail',
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
