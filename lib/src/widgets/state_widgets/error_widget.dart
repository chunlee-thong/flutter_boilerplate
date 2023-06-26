import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_plus/skadi_plus.dart';

import '../../core/constant/app_assets.dart';
import '../../widgets/images/svg_asset.dart';

class CustomErrorWidget extends StatelessWidget {
  final double verticalMargin;
  final dynamic error;
  final AsyncCallback? onRefresh;
  final bool hasAppBar;
  final String _errorMessage;
  final bool hasIcon;
  CustomErrorWidget({
    Key? key,
    required this.error,
    this.hasAppBar = false,
    this.verticalMargin = 0.0,
    this.onRefresh,
    this.hasIcon = true,
  })  : _errorMessage = SkadiError.getReadableErrorMessage(error),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    if (hasAppBar) {
      return Scaffold(
        appBar: AppBar(title: const Text("")),
        body: _buildErrorWidget(),
      );
    }
    return _buildErrorWidget();
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: verticalMargin),
        alignment: Alignment.center,
        child: Builder(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (hasIcon) ...[
                  _buildErrorIcon(),
                  const SpaceY(16),
                ],
                EllipsisText(
                  _errorMessage,
                  style: kTs16,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                ),
                if (onRefresh != null)
                  SkadiAsyncIconButton(
                    onTap: onRefresh,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    icon: Icon(
                      Icons.refresh,
                      color: context.textTheme.bodyLarge?.color,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorIcon() {
    return const SvgAsset.iconOnly(
      icon: AppAssets.error,
      size: 54,
      iconColor: Colors.red,
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
